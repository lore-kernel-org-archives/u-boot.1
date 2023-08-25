Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA7DC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5AFB86A49;
	Fri, 25 Aug 2023 09:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3MBgDOcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59A586A45; Fri, 25 Aug 2023 09:17:24 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B40C98655E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+F1ifemQNI7zG+GSNURPGrRleXiFkOqTp/5GKV4boGRPW7+8KdU/TBETEZ+OhPTfvUQTYvy7gffAhSTOO3nnbWG1vP+fVagaMIc722OprX9V4JRsyFyAEn+LaGVjk3mlON67W4btEXovNZnCfvZuVOk+xzAcixSM8Fn+Li4wTT8jjQnQpc2s4BbybOuFAaVqgLMSVGcFc+HWHv8oqaMnuv5MI+G47/AL6zNBOxgunberzqxEJznmtAa7BY50y+Gvv+gO1J5RgWAXh3XADoMcHANUzrECHf1zM49sWhB0wXKSGI1enXr19DC/0iNLZcy2c5I9FJteRzN9drrA8iMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTTxZwungpkFUmmg8FV1AfEeENnnyyyy7yC1NRU0c+Q=;
 b=QgWkmAm38EuX0QBklSIlfdspaIV8X3K3Q3pPyDIbu9PFvEkBjBrCWl0l+7ssDbr6T9TyL/kCB8YmjQCRhiwYlvIzs1nnJF2wEY7TvpyWwvJmgig9UDXLV5iK4QffmcNQr55f3Rod/FB4bhw/zuUbjuGkp3h+RaNM5+8SVWi7DWLtDHZQ2kKBM/8P5PIUUlNCEh1wgArVaXdvJC6rjbcbenBByebB+LhEI74/raMH8nN8tOQZuFC8Qd3s1PlnsJk+aovzE3lSjqkroJniNN3smv4TTJ7++BJ5sJwqIK6G9I03YOpTH7GuxfnowNvGPlrcLBQic4M0PzIxPslnTJrMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTTxZwungpkFUmmg8FV1AfEeENnnyyyy7yC1NRU0c+Q=;
 b=3MBgDOcggHRLfreell5Ll2tK598Svd5p/9ed5V0xG0CP2l0/r/daq8otsGlnQg52WHiKdo/sHfGD5TK1NcwfwFeaiBDifL/5mXDd99pi5rIIiLOQNtS8ALkTRWclTE58d+pr4lG24Dif77Z9ZmckSIJlQk0NxNIb4kGZ8JrGSdo=
Received: from CY5PR19CA0104.namprd19.prod.outlook.com (2603:10b6:930:83::21)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:17:18 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::bf) by CY5PR19CA0104.outlook.office365.com
 (2603:10b6:930:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 07:17:17 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:17:15 -0500
Message-ID: <1bae8050-990d-5aa2-ed02-a69dbe177cc3@amd.com>
Date: Fri, 25 Aug 2023 09:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] dm: core: Add support for filling
 script_offset_f/script_size_f from DT
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>
CC: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>
References: <cover.1691069786.git.michal.simek@amd.com>
In-Reply-To: <cover.1691069786.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: e3683e4f-875b-46d6-a30c-08dba53b50c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPSqTLhV49i0npAsku70y7u33MkRWq69Ng4HduOTqksCWaZU7NOSjok7V43P7Pla1T0nwtdTiCTsXEOIuIqPkegDDNmqWB526UJXgB++IQN+IaqLfoOyZPZYZSuvyAy9FYxiUNQSDILXDWWiiACel3ka0rSU+jUHJzX+r/2iTVtFwgHTmN3SDLo1VcPmoToqFLaMX2c5K+bSOt2pwuO74kydEtv3+vF+wwZTxIzm61gYpzRql/V+KbM25gcEkImQR6RdNR/wk8kx4d/kF4clCmBLNDEK12SYD1Hb1wunlHoz9LhPYX0SQgL87OpAF9NbJ1xOqKNY2jnHFk647PbkD/A0X7X2BQDJpuJTBdYF16zXJli2Zucy+JaKsvA64F+B4UfQEf0oFiX44a4OlMOPWc158uI4le53nQXg2QPyXNkZP1VGEt7qTMr7+QnVYGN0tlMZQF/rl58sKiGojnI2UINjAPudIwIFR+JCrNrbeb9FINckZMzvce3ZL0uv1TkLsa4OnUevnPvkWhRgO3vuipHzGLMRSbHyVjWQ94ueymDsKoTZNqMB73hpbX4AfaJc9gPCXApu86yYKWlnKpuyi8TvebJ9zlyanR7Gk1M0z7M6zmQ/u07+/1UE3KstfMcfqCLkQcnnTF9R8ngRwn2iZ/3/9JouJmR/wveaBXwybqsHqFSvdBska6Elmuph14HqCIRT2m5vyau9ARXxu7b7vUHM5GwvU2XiFNp7xdpu6YVdKBGiK5U0eH57NOchXl8OVjbEtCyoAS3CUuVTR9UtRNWimZhLS1e1oR9VNE+qYPgnn+parrJobg3o83Hux+FXipvoH9x+g9cbcOH0kHvfoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(426003)(47076005)(36756003)(83380400001)(44832011)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(81166007)(16576012)(70586007)(70206006)(54906003)(316002)(110136005)(478600001)(966005)(31686004)(53546011)(41300700001)(2906002)(86362001)(31696002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:17:17.8615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3683e4f-875b-46d6-a30c-08dba53b50c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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



On 8/3/23 15:36, Michal Simek wrote:
> Hi,
> 
> The commit https://github.com/devicetree-org/dt-schema/pull/105 added
> support for reading memory location where bootscript should be loaded.
> This is follow up series on reading information from DT where boot script
> is placed in flash memory.
> 
> Patches are based on
> https://lore.kernel.org/r/b37aec1460d93727a9065766aa5f50fa356ae5aa.1690873880.git.michal.simek@amd.com
> and
> https://lore.kernel.org/r/b77352af92102dfad2e12a49a7680f5f64f8ee31.1690873880.git.michal.simek@amd.com
> 
> I didn't send pull request to dt-schema yet because I want to check logic
> around it and DT variable names bootscr-flash-offset and bootscr-flash-size
> are correct.
> 
> Also there should be follow up patch to remove CONFIG_BOOT_SCRIPT_OFFSET
> Kconfig symbol and remove variable script_size_f setup from config file.
> 
> Also keep in mind that this is pretty much just 1:1 conversion between DT
> and variable. Upstream code is using it for QSPI only and we are also using
> in for NAND devices too. But the same approach could be used for DISKs,
> EEPROMs or SD RAW. That's why I pretty much think that DT description
> should be done a little bit differently.
> For example:
> bootscr-location = <&nvmem offset size>;
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (2):
>    dm: core: ofnode: Add ofnode_read_bootscript_flash()
>    xilinx: board: Add support to pick bootscr flash offset/size from DT
> 
>   arch/sandbox/dts/test.dts   |  2 ++
>   board/xilinx/common/board.c | 13 +++++++++++--
>   drivers/core/ofnode.c       | 34 ++++++++++++++++++++++++++++++++++
>   include/dm/ofnode.h         | 27 +++++++++++++++++++++++++++
>   test/dm/ofnode.c            |  9 +++++++--
>   5 files changed, 81 insertions(+), 4 deletions(-)
> 

Applied.
M
