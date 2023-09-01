Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F0ACA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605F28669D;
	Fri,  1 Sep 2023 08:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCtWR8Qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE2C68669D; Fri,  1 Sep 2023 08:11:51 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DBD865A2
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSuIP2ZCHxQm70bpCW7mTGi0ck+xSfuXyzBl7YjzokO2WdJYjc9292QQTQD/qx1rLxhoMXP4irZRI1Wf5FsL6JgaT6fjg98jPAnPE3U2RVZLisIRJXBLFimP8aLTl6gzw2PYZ4iT+7WM2LnMFWUSLFw+CfLPD+aQ4TE7/9/sJUlzg5uKtQrgEgDJtOUsfalkZ1XPYrq+i+vszRwREsjqGvjx2WoS72QvYwphK1eBAbLsPdEfS57pi+K/UWs9RxyURNQMZ8A3Qr2o0P/5ZD521ema42Y12Pcjdg/3Wy3LFaDPKjPGDIGuSjlCbwbMMMQ5mksA92uu2YA4saXjUix77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6lRNDcW7pDPazKAD2gXcbPwPKBTrBUt6kQaZzSjXvw=;
 b=FQHenTzD6vqq6hME+BJQeuULiMHniXjBvu37+4uiXjeUa+WID0iJR3+BWJD/VZhNOfajV7b8xRBw4dmzvAfaxkmzC6nlgln+GOjgLT/4WpD7h2NIK1b0SWvU+6wkudsTOCtCepM056QXa6uPrwuV3LCfI/eJulJG/5E5NZfzKUKEki9b8jdJm/gvG7aLI34LTuoUL/fgZLPWri8Ec8s71bFnIyyNwob9JXF2ocMef0PRLufvqBlGZdfQzyZeRQR0DwkKVXY6e8ECY7uchTZBHpfUTx1/6VcizXsjTlsNLwFig7pbel7FR1CwUYGo+PiL/cLG/yJoL4VqQ9kEizf9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kwiboo.se smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6lRNDcW7pDPazKAD2gXcbPwPKBTrBUt6kQaZzSjXvw=;
 b=NCtWR8QiXDenHlAA56ECzYdFZUPfb5Qkl1Xy3eAOkSrQ/SuSuUmRvFNtByS5JXRf6aChkRMfyum+BBfm5i6iR2zPZadCPnu3nzPKQzGsqFH/ewZqVKmcVmw/hhp5Rmdz52Le4C2Itm1YFbbSk9eZVP5zIDwDJCLOYxgKpTP3WYw=
Received: from CY5PR17CA0029.namprd17.prod.outlook.com (2603:10b6:930:17::31)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 06:11:45 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::8a) by CY5PR17CA0029.outlook.office365.com
 (2603:10b6:930:17::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 06:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 06:11:44 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:11:42 -0500
Message-ID: <69dc6ab7-1c61-715a-421c-c60c37b2534f@amd.com>
Date: Fri, 1 Sep 2023 08:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/6] scsi: ceva: Use generic_phy_valid() helper
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <u-boot@lists.denx.de>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
 <20230831221629.1027552-5-jonas@kwiboo.se>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230831221629.1027552-5-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a52ab0-c623-4cae-7f2d-08dbaab2512d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsgAYTGdArIZZjv2aMqiD1mNOGYD5GD9zOrb2jJuhnVr35tTp4Mj5/UmbVGY8CToDMC3+ms6upe/UhVLJtpXs2ZcxITTMp9T4rVRGcPxp2X2KjcM2jFtprMpjiVLKym400ca5RVFTo53ff49esm3RlcczCKOpfML6XhdHHfEyJfnZGqNRj+IKWi10X52tIxvpG6Uszhtx0MeXhTNNQeFjLrXK27grs93bnys4zOLVEAao5i2d4MTTRqO9eoqb7yhl22eKcWE3D7A8xqZhUOq+O2ZTHHwFlqRdrlu2iAo6TK6mQgkEA14KIk1Xfv8SAhlXVOIvCO3q+cXxYtXmjormpHCl2PJWDsh1/P54ePfG0lJddweR3kA3glgpkl60VgwtNjQPp91KaXgBfX3j1wGLdPTFVv9V7EMsP4gxDBL4Cbwf7Q2RFc1vYjj7tvlDtAzC7pgLV+ItGa9kZAOhXH3zmHi+hIl2zG0MKOGc3njEgd2EiJ/FvPsYw+QgoH9+MKcCBQ+/+p5QCBSfxX9ni8eEcdVygc5D4QGkZ6qd/x1FiFjdnNwGiXlVkAijZepCc1pQ1K0pM6OffEj7+hf+tKjnK8P5eeY2xtcjk1sVQWcBlN++qMYezowVWaVPA5CD3SX9UYHIvc7HTOdD6CTADukaE/Hi1LjIGp//BMIm2lQ/CE0a9uGRWveD/aeUMt1FBcy0owtHaDRfh6Kj4wElUgAUvL4maLNLMPMEWrUbEzTNw6/BVZj13r96KqJD6Dx4FsxkC54gEm5bF1uSoONFpuPZ12vxjda75KQu+aTp3fF1l/NiKxF+JE+KlPQNvRk1RDD2P76fVZUVyRBJgUOO6Z67g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(53546011)(478600001)(83380400001)(2616005)(26005)(336012)(426003)(16526019)(2906002)(4744005)(44832011)(16576012)(316002)(41300700001)(70206006)(70586007)(110136005)(5660300002)(4326008)(8676002)(8936002)(40460700003)(40480700001)(47076005)(36860700001)(36756003)(31696002)(86362001)(82740400003)(356005)(81166007)(31686004)(41533002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:11:44.4800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a52ab0-c623-4cae-7f2d-08dbaab2512d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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



On 9/1/23 00:16, Jonas Karlman wrote:
> The documentation for struct phy state that "The content of the
> structure is managed solely by the PHY API and PHY drivers".
> 
> Change to use the generic_phy_valid() helper to check if phy is valid.
> 
> Fixes: f6f5451d469b ("scsi: ceva: Enable PHY and reset support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/ata/sata_ceva.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_ceva.c b/drivers/ata/sata_ceva.c
> index 47366438fdfd..7769d4f99efd 100644
> --- a/drivers/ata/sata_ceva.c
> +++ b/drivers/ata/sata_ceva.c
> @@ -217,7 +217,7 @@ static int sata_ceva_probe(struct udevice *dev)
>   		}
>   	}
>   
> -	if (phy.dev) {
> +	if (generic_phy_valid(&phy)) {
>   		dev_dbg(dev, "Perform PHY power on\n");
>   		ret = generic_phy_power_on(&phy);
>   		if (ret) {

Applied.
M
