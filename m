Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F977C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 09:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913238642C;
	Mon, 18 Sep 2023 11:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAwhw1yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CDC180274; Mon, 18 Sep 2023 11:08:23 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A75568642C
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 11:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSkOOScUcvufQ4rWgIA+ISWCprOEagmoERWtkIl0ukCe4Wn4AhzofKF6g+cyydkOhJPHlyXwbqFX2LbB1F+F7eJACxRKeXNEsOefdvNoqxwt9YgvTLQwgrce6VzmocU3YDdzV/5NsP7qcOBbVp3C5xnQp23n2aRyJbZplwpyfiCmxQAsB3CbM+wKRPxms8NXC+UC+RUF/aSY9iiYTYwfpzDd1Mi/M01lHIzh64mXn30Yy7/FRBsNmCvvamwh3ohj2jGsxn5GV1ydLKFv1ru2hjVbsUc04FZ/jCzyWBRn6RdNQVuDiqb33rlOAXsxeqlRa/SQ9KtLRM3npmoWxFJAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do/ZOz7G6vOx1ZeiEtOnkRaU2XJTfT5ITfoBiR2wmXo=;
 b=hBxTAQH0BuXllBM250+a+s5ImmOgvGOlf2HzEkd2YowNtuNRNX0zC375KGg9h0+an5nN8ezdeF67EjxxoBubRes14YCHhHi1WQ3v62OYmr3kZFlOzsiptFR/+GFnT2kQ6VEEdqq9hxvdXNwqrMucmVfSZK9nNh/IKfH17aMUhnyLcm0FGqucB84uS969wkKIDNXbdQdWqvl3vgi3kGndNJB5zFxSAJ1K1jTzuvgbzbUgpSFpzhookelsetnctDvUYXr78f7mGOXmLEWn2oS5zm3EcX8PXMDLwJdXMIkwdWMxta21aTvXqGmrfcImFU23BRlTRKAtUy5mYpiDLubeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do/ZOz7G6vOx1ZeiEtOnkRaU2XJTfT5ITfoBiR2wmXo=;
 b=rAwhw1yp8oJ4rXzzatB5U/zQnDLlqgiNT5LSSgSJg44++KBBqJmBgjZkvlYzKNJm+DBc3sW3ywZljVWvirxbZmwX7ExdtWHNRGOCjJh9wLPj6tUWXleFmdPbegQkO1D3CBqqWTbbqvX4g8THIOtN90tuEfag7yFYgCazxB8nTwY=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:08:18 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::53) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 09:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Mon, 18 Sep 2023 09:08:18 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 04:08:15 -0500
Message-ID: <ba53c160-8a27-4a35-9c2a-ea3ae072b664@amd.com>
Date: Mon, 18 Sep 2023 11:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix dependencies of USB Kconfig options
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <rfried.dev@gmail.com>, <seanedmond@microsoft.com>, <tobias@waldekranz.com>,
 <sr@denx.de>, <john@metanate.com>, <git@xilinx.com>
References: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 17059230-8feb-45db-13e4-08dbb826cc82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUvfKgVZeo6qK6Q3fqqgM+tITaYO75s28h4FTiFi8dGbRc53XRIMvQiJchw6eyyFWUziwSDNDTgP+juYLB9ex1pFTSVh+z+PR3pY2kDLzHuC6QaQmjDBPPezdsYM9TsXkUTLQAKLSFTS6HG88mf8D1EUxDbBf9QF6OLk7IesNSbUZyJAp75ThCulNky41T4rmACiMNkrLqTRP26Y20H1Y1SEFhcjQWpedOtptF6/qmErv7wZqFBe/8IVK4SeeTqQGk2dl/gcMYi88Twi6vgeR5ZdKLgw0WPZCWXs6d8WlIdPwBqhRtVijq9LlurZAzDwt9J/n27mL6z2nniq3WYJwOoxq8DcNo5g6c9wcVmBMeBRGeO1mByGHwi+Vra+LPNZVAh5NyFy2zqRktbQyGqZio+dQARBlnsVLnn0sig0facapw2O8lxXYlWjCtkb9+Cux7JvwU4mLA/4zdkfszOfjWnrHgWNo+1qAI0VXmmkYyX1Z5u3Q0TpTr1HxJ+U73eDdrHYpJbyIWR2+kQzMzRQOP2IJcfSvad6QN34QiYJoitd6u+HeUsg+BTlI8bizgzW6FWTdiho2U3KG/PO7SoUjHW2+eeH7AkE83+SdalVcUTMeki+/cVXsESxqow4w2CY3ALIhyDvo3XKPSO8hSxkL2cwb25cgAoXQpbopE8OoIu1OMkbS5/9Ckv9KFxtsrKNKbKmdVlkG4cAK1OX+les7dSqsMTRYgr03Tz/g6yXClxYQP9T+BB1u50RCyGCiTOXpia7tBr6FbTU/edOn+Px7pD+E59C3WkViQmr+AY1x0FpouKbVuAIZAifZvhuB3tL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(16576012)(316002)(4326008)(41300700001)(8676002)(8936002)(16526019)(107886003)(26005)(426003)(2616005)(83380400001)(40480700001)(336012)(6666004)(36756003)(53546011)(478600001)(82740400003)(31696002)(86362001)(356005)(81166007)(47076005)(36860700001)(70586007)(70206006)(40460700003)(54906003)(110136005)(2906002)(31686004)(44832011)(5660300002)(7416002)(4744005)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:08:18.0839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17059230-8feb-45db-13e4-08dbb826cc82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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

Hi Tom,

On 9/4/23 05:15, Venkatesh Yadav Abbarapu wrote:
> When USB device driver CONFIG_USB and CONFIG_CMD_USB are disabled,
> some compilation issues are seen. Also CMD_THOR_DOWNLOAD should
> depend on USB_GADGET_DOWNLOAD. Add dependencies to resolve those
> issues and compile properly. Also remove unused config CONFIG_ZYNQMP_USB.
> 
> Changes in v2:
> - Added the dependency on USB_GADGET_DOWNLOAD for CMD_THOR_DOWNLOAD.
> 
> Venkatesh Yadav Abbarapu (2):
>    cmd: thordown: Add proper dependency for CMD_THOR_DOWNLOAD
>    zynqmp: config: Add proper dependencies for USB
> 
>   arch/arm/mach-zynqmp/Kconfig         | 3 ---
>   cmd/Kconfig                          | 2 ++
>   configs/xilinx_zynqmp_virt_defconfig | 1 -
>   include/configs/xilinx_zynqmp.h      | 4 ++--
>   4 files changed, 4 insertions(+), 6 deletions(-)
> 

Do you see issue with these 2 patches?

Thanks,
Michal
