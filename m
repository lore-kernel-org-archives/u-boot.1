Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A627E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 10:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C28586413;
	Mon,  9 Oct 2023 12:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E9UUvqSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B4186AB9; Mon,  9 Oct 2023 12:12:56 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5238638B
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 12:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTLTOOpNCoxYKKVFRZQex9jRPsviF2jRPU8N4fS35LbPp2ruMoHAdgA6z+RubjvumKq6xmN+5saNq8iamjafzLEdO6g0OQhZO0m6ops7qw5RChJlLPCSoXpY1cRhEZEgbgtBJyt6GQdP97EfkAqvTalNvjJcIifH0dGbK+yoW4ValUsIwx1fvtuxNjZ8ALzvi0XspkGvDjTZvDscylJIeVBq7caxmw49zibOx4Lkacj84IQn30qU4Wm3O5kVDdisFDehtmtvs8lK1ifuVNxty0BITSumDDrr4KoV68HFvTF6abqilbox1AJW3Ot3wSN2TVS58liIkOvakOjzSXuRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzv7fDb6WAGzUVhDcX+SVZE4k60azk7q7JD6RUN/esc=;
 b=ll0Uq/8LKp4cv2rTG3pIzs1wyRjRkYTha7yBrvWsXWqACymKoVtAqIfiWjKSQPBf0PNy91bN4x/N/rZ2tbEAgMZ4L0wxlUY85W+iTNYgRA2RnSaIgz2j2Fhg0+Wm5knCMQ9Jg91hDPtPW1xL3IasmCZizVVOuXh8z0dTo1e95oozntkzsGFG2bfxxJc2IlNrxo63odQiVs2DPW1gYe/tgBZW+RAqn1WOZIncIGQAXZPcO94d8MeNb2bLXXmt3hOKUweS5/YxGs3LDvM7kgPABH/d6VpEx9kHR0ib2mAkwX+QFgY3bsGCmdM5wOqm3lByQfrpq5DCRn8zuCPvoov0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzv7fDb6WAGzUVhDcX+SVZE4k60azk7q7JD6RUN/esc=;
 b=E9UUvqSfwbjo0YBE8Llu/hdTni2+DSiAeQ41WcVCKNHG0x5EiFoJx2GiCBrkYwSwhD54IjRxA7WtERXziqP0FT8++CHVkZUZ37R7rAXw+MPaWosdsJ8CQKERiYrRxzXNT22WwFq7myPXq71RoXRpy/U4N4g6pcc4mLOQhi+ofd0=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 10:12:48 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::44) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 10:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 9 Oct 2023 10:12:48 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 05:12:45 -0500
Message-ID: <a61e77fb-9049-4366-a575-32ca238ad32b@amd.com>
Date: Mon, 9 Oct 2023 12:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] xilinx: add missing boards/SC descriptions
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <cover.1695808407.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1695808407.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM4PR12MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd06457-7c54-4d38-1da5-08dbc8b049f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WciRuLg9uEw18oxO9qUXETz9l7oz7o5tDXvnYEfrZJblbScJRsqVXbVeteSJ873VPtTnpMaqMxqePhhFZ86sGvzYYhY/fd/uHyVCiF7A4n4D53FSqBcWiTKVj8VbPLHcL+RbmcVDfvcMrk9FzLPpKif9fCdAW64cTZZEis+z9z/lWeU4f4cML4D0+Vr+Y3TZsMn/VHK3ZNcFNt/iXm76xqnMGAqFQ1fYHcM/UPFjBqmytSy7bl02LiJACmMA7+9Rt6G4irxTHTkDnDg5wEGY43DDd4Hy+QWnw/pL0fSgEDwkGA0obZdvP/7tTvkK5CG3pWCisHi323VuWEtsjEk8lvBPxcvghp7evbV4ly8UuzpSbWd2lUGCHbfKcDpksQk+fskTqzTMLDZzOU6kzea17qH2Cl/TUX61h9iJRfeD0mMeRUpD0JnufTZNNJv0eTk4bSbKNniG5C4FWQVN8Tk+oYwNYuP1yAKbMN9bS5F5i3rHH4nEphP4RlIkA9ATD1LxEVuJE16Vp+Oi/gqoXPpR/6milb8O8nwrOUFQdqeg3NlMvdDCIqrtBgifaKB47Oo4FvAJSJ5T5drqVQq5TN51GWLMZkbiZoIoIEahZ8O6v2bomH58hqHhnA3S59im3UjVilh3sMuBLs6MetFiZt44ap7JJlUmveuY4uv8Wm/fPl/Arwo8DOqV/tRMIZXtzaOQShU0Qe6bfgGlrg+5F48I7amuUfqc08+U+UOPm0lFjDm+B5pmKllqTXXCzvXEs9fZl55rYx1XoSedTHlyOf+MtM0fjic5ci9+u3PBzbEpEs1+u5rpnm4TS4YI9/2gH95
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(31686004)(2616005)(426003)(26005)(336012)(16526019)(53546011)(40460700003)(40480700001)(36756003)(86362001)(31696002)(82740400003)(356005)(81166007)(83380400001)(8676002)(2906002)(478600001)(19627235002)(47076005)(36860700001)(8936002)(41300700001)(44832011)(5660300002)(16576012)(316002)(70586007)(70206006)(110136005)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:12:48.2563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd06457-7c54-4d38-1da5-08dbc8b049f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 9/27/23 11:53, Michal Simek wrote:
> Hi,
> 
> I am sending series of zynqmp boards mostly related to system controller.
> System controller is small ZynqMP board sitting on Versal/Versal NET board
> doing board management. There is a internal spec about connection outside
> but pretty much DT description describe all connected IPs.
> The only thing what it is not covered in generic SC are i2c buses because
> they contain different devices. That's why they are described by DT
> overlays.
> The first version was created for vpk120-revA, next was generic SC revB and
> because of supply chain issue ethernet phy was replaced which ends up in
> revC version.
> 
> The series also contain some cleanups and also adding new platforms like
> KD240.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (11):
>    arm64: zynqmp: Add support for KD240 Kria SOM CC
>    arm64: zynqmp: Remove xlnx,fclk nodes
>    arm64: zynqmp: Add support for vck190 revB system controller
>    arm64: zynqmp: Add x-prc-01/02/03/04/05 revA support from SC
>    arm64: zynqmp: Add support for vpk120-revA
>    arm64: zynqmp: Create description for generic SC (vpk120-revB)
>    arm64: zynqmp: Add support for SC revC
>    arm64: zynqmp: Describe i2c structures for SCs
>    arm64: zynqmp: Add support for VPXA2785
>    arm64: zynqmp: Add support for zcu670-revA
>    arm64: zynqmp: Add support for zcu670-revB
> 
>   arch/arm/dts/Makefile                         |  20 +
>   arch/arm/dts/zynqmp-clk-ccf.dtsi              |  18 -
>   arch/arm/dts/zynqmp-e-a2197-00-revB.dts       |  34 +
>   .../zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso |  76 ++
>   .../zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso |  76 ++
>   .../zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso |  80 +++
>   .../zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso |  86 +++
>   .../zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso |  86 +++
>   arch/arm/dts/zynqmp-sc-revB.dts               | 430 +++++++++++
>   arch/arm/dts/zynqmp-sc-revC.dts               |  37 +
>   arch/arm/dts/zynqmp-sc-vek280-revA.dtso       | 230 ++++++
>   arch/arm/dts/zynqmp-sc-vek280-revB.dtso       |  15 +
>   arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       | 321 +++++++++
>   .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 460 ++++++++++++
>   arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       | 326 +++++++++
>   arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       | 371 ++++++++++
>   arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       | 337 +++++++++
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso        | 353 +++++++++
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    | 438 ++++++++++++
>   arch/arm/dts/zynqmp-vpk120-revA.dts           | 574 +++++++++++++++
>   arch/arm/dts/zynqmp-zcu670-revA.dts           | 669 +++++++++++++++++
>   arch/arm/dts/zynqmp-zcu670-revB.dts           | 672 ++++++++++++++++++
>   configs/xilinx_zynqmp_virt_defconfig          |   2 +-
>   23 files changed, 5692 insertions(+), 19 deletions(-)
>   create mode 100644 arch/arm/dts/zynqmp-e-a2197-00-revB.dts
>   create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-revB.dts
>   create mode 100644 arch/arm/dts/zynqmp-sc-revC.dts
>   create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revB.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
>   create mode 100644 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
>   create mode 100644 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
>   create mode 100644 arch/arm/dts/zynqmp-vpk120-revA.dts
>   create mode 100644 arch/arm/dts/zynqmp-zcu670-revA.dts
>   create mode 100644 arch/arm/dts/zynqmp-zcu670-revB.dts
> 

Applied.
M
