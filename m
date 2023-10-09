Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8DBE95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 11:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3608652F;
	Mon,  9 Oct 2023 13:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zF5b6ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F05D8652F; Mon,  9 Oct 2023 13:11:05 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E96086B68
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 13:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlymT9g3ExBeJHOOztd5cMMs9X95h96d2NO2uYQBzIEB/xAMK5arsG44/F3+J/8VZ9TlAUGx6DGaaFZXElA7iZLC+CcFePTR3jggNboiiJ+RVqDMnsSlpHL/I4GwYSPun584ygCuGaDg3LBd6Dg8FcCQRSYyHmNS46buP5gXoTedJMyh39TNPVcfeIHXfwqsogorob4HMUPpm1+u8qF1DkkQJ891R2e9djd791zx/donAwsIH15WqGCS8g//Sm2fqhT0Cy2QGYcpGORqciTH9BEuZJUeBmpfzFbdrYsvPvizobj5exKPPOss27rqCeTwh1CvoGp66PFDNSXK3idarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UGthZD1FPTga9gfs+ajw8+Z7lZ43co7tWrNR9eNarI=;
 b=ic8a3aWhfdtDbolFv3UDpDHE8T7wfrqFGScu5Yq8XaRqvVENbW2O3jR46vThTWHxbo9pPjR7EH/QQdRHlSV2Pp3Ymqo2H6BSSFWOA3EXtg651fku6PNSLyYINs6ox+SNpQt2TfQ6Ainn1EOd0fJlXHBamJ5D1Q17uv4UsbgJqfT0q++nXg/dVB9uvXUs9iDrUJT2lZu8xr1dvETeMDQdFURfWUmJ0cVqbCnYH5L36RjjOxROp6N5pseBTuw6Go7UkWfeCeGsp3BmpOndgF0UZ2sOaWlX+IkdV6xWaPh28IaJIsYMhjFhIqjyNm+W6fSwwh3oAPEn9Dsyk5qoYKDIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UGthZD1FPTga9gfs+ajw8+Z7lZ43co7tWrNR9eNarI=;
 b=3zF5b6evMuYg711Rn1T+QV902cNAsIwqWQUhHnG7rsSJAIPYBWoukMCDAtMXrc388WdlKtrR3tOT27mZR8SeaU3LmRaU1Cc6pWvVIgOz3gG1/Nlu6dDespGCrjjnsXjU+xrgHlxaQtrmoYN6yvLCV3a3dq7cJ1N0m1iTj3JC1eQ=
Received: from CH0PR03CA0304.namprd03.prod.outlook.com (2603:10b6:610:118::28)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 11:10:58 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::1d) by CH0PR03CA0304.outlook.office365.com
 (2603:10b6:610:118::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 11:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 11:10:57 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 06:10:55 -0500
Message-ID: <b61dd362-7b53-4e62-950c-a86d7850d579@amd.com>
Date: Mon, 9 Oct 2023 13:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: net: Add a TFTP put test
Content-Language: en-US
To: Love Kumar <love.kumar@amd.com>, <u-boot@lists.denx.de>
CC: <git@xilinx.com>, <rfried.dev@gmail.com>, <v.v.mitrofanov@yadro.com>,
 <seanedmond@microsoft.com>, <emohandesi@linux.microsoft.com>
References: <f67478ee2642e6c598da4364f84c3bec900f89c3.1696323438.git.love.kumar@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <f67478ee2642e6c598da4364f84c3bec900f89c3.1696323438.git.love.kumar@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 33718aae-7a8a-4d26-3cfd-08dbc8b86979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwjA/V9F/LsltHm18Wj+oxgm9OHsioL4rEEEjVEuf5vm8Ca/NofqrCrKfcYXB8rDsZkkx6CdYPMNBNVhUkvwRCseU9Nts3UPTA5XpmRSu7IvYx18bQ4jTP8WssV+RkTouqsT3bJf/pVEawX9ByYynNJRDIgxSZEayCcFYE+MH4X9Ljr1kPW72xux5E1y2/4EK38wVNl7u5fMuSvDU27zPu9q4m3gi2zM4RUAMHNZfkTQYK0x7cytDLlwpgauuJvu50t4DSlF1EnVA6cchgjflg21hEtrXR5SqRJqGrzM4J1gMxKaIdBqCp9fH4jSQ+hIHcVSNA30jyaPZ9S9vFEcV9nzDr0S75MP5iHHxesHs2xbXglaUaISAYE53UOkPs5NP1cKkY6A4918Qohlva9KL2AiLnYZs0fXjNoGQDpTQhA4yteuCcyXb94aM0qS/XNJr8Fuc/iedHukSB2Ch3JqxCose2DgWH8nybvgqldtTIvO76VvSVGY3pEHMgkDuMIebnsNmxUBqVNVnDqN4nwrh9Qzx1/A+CYcCcgB5J6KFQiLBrveqaZIRKbVUiBZEWUsyJoOda/g5AQJQNRJHuzGHoIpNbSUEQlyEoEZGhnXJNs0vh742gU7e1eDDlbgRyBcs4rQ4yBh8PD+NaVsMqzZd8Rhuqb7DUSDUvomOjMsuzdktYs9UIm4ekfSAtLg+aNLwuijoCdLo53kyko+BbcnFo9Q4ND1sQokTxgGRDYKwaBt8LFBjyiLZfn80RxzaekqfqgSqSxuqwntQ9yhgIb4h50HPUqcYQM++QqxLDst7YDQhEIw8m6Tk5NMx2F8l33q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(81166007)(31696002)(356005)(86362001)(36756003)(31686004)(40480700001)(82740400003)(2906002)(478600001)(44832011)(41300700001)(8936002)(5660300002)(4326008)(8676002)(53546011)(83380400001)(426003)(336012)(2616005)(40460700003)(36860700001)(70586007)(70206006)(54906003)(110136005)(16576012)(316002)(26005)(47076005)(16526019)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:10:57.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33718aae-7a8a-4d26-3cfd-08dbc8b86979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
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



On 10/3/23 11:02, Love Kumar wrote:
> Execute tftpput command for uploading files to a server and validate its
> size & CRC32.
> 
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>   test/py/tests/test_net.py | 69 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index cd4b4dc53cbc..f69e3ea2dbba 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -6,6 +6,7 @@
>   
>   import pytest
>   import u_boot_utils
> +import datetime
>   
>   """
>   Note: This test relies on boardenv_* containing configuration values to define
> @@ -50,6 +51,7 @@ env__net_tftp_readable_file = {
>       'addr': 0x10000000,
>       'size': 5058624,
>       'crc32': 'c2244b26',
> +    'timeout': 50000,
>   }
>   
>   # Details regarding a file that may be read from a NFS server. This variable
> @@ -260,3 +262,70 @@ def test_net_nfs(u_boot_console):
>   
>       output = u_boot_console.run_command('crc32 %x $filesize' % addr)
>       assert expected_crc in output
> +
> +@pytest.mark.buildconfigspec("cmd_crc32")
> +@pytest.mark.buildconfigspec("cmd_net")

Here should be CMD_TFTPPUT marking.


> +def test_net_tftpput(u_boot_console):
> +    """Test the tftpput command.
> +    A file is downloaded from the TFTP server and then uploaded to the TFTP
> +    server, its size and its CRC32 are validated.
> +    The details of the file to download are provided by the boardenv_* file;
> +    see the comment at the beginning of this file.
> +    """
> +
> +    if not net_set_up:
> +        pytest.skip("Network not initialized")
> +
> +    f = u_boot_console.config.env.get("env__net_tftp_readable_file", None)
> +    if not f:
> +        pytest.skip("No TFTP readable file to read")
> +
> +    addr = f.get("addr", None)
> +    if not addr:
> +        addr = u_boot_utils.find_ram_base(u_boot_console)
> +
> +    sz = f.get("size", None)
> +    timeout = f.get("timeout", u_boot_console.p.timeout)
> +    fn = f["fn"]
> +    fnu = "_".join([datetime.datetime.now().strftime("%y%m%d%H%M%S"), fn])
> +    expected_text = "Bytes transferred = "
> +    if sz:
> +        expected_text += "%d" % sz
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output = u_boot_console.run_command("tftpboot %x %s" % (addr, fn))
> +
> +    assert "TIMEOUT" not in output
> +    assert expected_text in output
> +
> +    expected_tftpb_crc = f.get("crc32", None)
> +
> +    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
> +    assert expected_tftpb_crc in output
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output = u_boot_console.run_command(
> +            "tftpput $fileaddr $filesize $serverip:%s" % (fnu)
> +        )
> +
> +    expected_text = "Bytes transferred = "
> +    if sz:
> +        expected_text += "%d" % sz
> +        addr = addr + sz
> +    assert "TIMEOUT" not in output
> +    assert "Access violation" not in output
> +    assert expected_text in output
> +
> +    with u_boot_console.temporary_timeout(timeout):
> +        output = u_boot_console.run_command("tftpboot %x %s" % (addr, fnu))
> +
> +    expected_text = "Bytes transferred = "
> +    if sz:
> +        expected_text += "%d" % sz
> +    assert "TIMEOUT" not in output
> +    assert expected_text in output
> +
> +    expected_tftpp_crc = expected_tftpb_crc
> +
> +    output = u_boot_console.run_command("crc32 $fileaddr $filesize")
> +    assert expected_tftpp_crc in output

I pushed this to CI to see if that goes through and  I see couple of failures 
like this.

test/py/tests/test_net.py:409: in test_net_tftpput
     assert expected_text in output
E   assert 'Bytes transferred = 5181868' in "smc911x: detected LAN9118 
controller\r\r\nsmc911x: phy initialized\r\r\nsmc911x: MAC 
52:54:00:12:34:56\r\r\n*** ERROR: `serverip' not set\r\r\nsmc911x: MAC 
52:54:00:12:34:56"

_______________________________ test_net_tftpput _______________________________
test/py/tests/test_net.py:417: in test_net_tftpput
     output = u_boot_console.run_command(
test/py/u_boot_console_base.py:269: in run_command
     raise Exception('Bad pattern found on console: ' +
E   Exception: Bad pattern found on console: unknown_command

test/py/tests/test_net.py:409: in test_net_tftpput
     assert expected_text in output
E   assert 'Bytes transferred = 6096080' in "*** ERROR: `serverip' not set"


M
