Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D4CCD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340B0864E7;
	Tue, 10 Oct 2023 14:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vto32Ouh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3ACE863C3; Tue, 10 Oct 2023 14:56:53 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B9F864E7
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX1DvXKtv9KU6RN/flbGDV9zvYgtsfSHl3Fe3OXhJDlHu2SKHduAiu/b9VtnNZoN/ijYHAhLomIY9QxQ+fACVH/+9OHexEyoXvacY92KGaJy/osQDFMaXvJKE6YDOUas/VwhoRWXoPnaWhQWP9D/W00zyfNMi9wBZNusNQI7lX5EZEq3vHF4gbF8wZOLnY8tLhG3N96IBtu8A5w/DOVXvyRef8x+1sJvG5Zw/i8tbAa5JpNpemKBx3SSQphhl0FloOSeueI4o5WjOYIQ3kOmGOOlYTPGRMrByREI/yX536lIUDbFZ+mKkJOfkPN5GrmfplXtGesw1F1BQi+iyn6YtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xulAkmwTfDn/DCJgVLv4wXcHUasaOmFoV8Bx0O7c0w=;
 b=lcPivh3dKkWp8xMb/yYnVwGRh7EaYk3wFDgsJikOeIQLf0JX/UJTk8LlRZriH33qd0ER1XzHfgefDZccl7I6QRds0GqlNplOUtt+Mye3Y/XMNAL35jwIa5j+bg4p4zmNzWLR5W8pGMNdHJ8P8WkkRoJd7N8www9Xu0J+a7wxyVvt6uivYqlGExiQr4k691cs4jVx0qQImjDulLeLTukf3uFCSRsLe+0Q55jMCHImgjylwaG/fshWT1h5d0p71ghe47oim+Kd3noOmq5zOLXLuA9FcLgAiUBQKMH3yP8R/y21kQUe1ML7PeJvUY7zAxESqyTHYUbbBCNMHVBYXuf4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xulAkmwTfDn/DCJgVLv4wXcHUasaOmFoV8Bx0O7c0w=;
 b=Vto32OuhxzI7JztQO2gsJE0GM+j9jjp1Ai6Dtl1vU9GQ6/l2cw36YlNxgSUJ0KyVtUl87CD2axeojkApEO6Cye1deCZNPxkEr7wjk4T7nSicLQHET02jy+WfrnstmHnyLtmOpxWuBV9fSZUdYRc/Q95YnFx+eGwlyW1gySOk3xU=
Received: from CY8PR12CA0015.namprd12.prod.outlook.com (2603:10b6:930:4e::15)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 10 Oct
 2023 12:56:46 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::7b) by CY8PR12CA0015.outlook.office365.com
 (2603:10b6:930:4e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 12:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 12:56:44 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 07:56:42 -0500
Message-ID: <53c50112-e895-4a60-bd32-186e371d19ca@amd.com>
Date: Tue, 10 Oct 2023 14:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: net: Add a test for 'pxe get' command
Content-Language: en-US
To: Ramon Fried <rfried.dev@gmail.com>, Love Kumar <love.kumar@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, <v.v.mitrofanov@yadro.com>,
 <seanedmond@microsoft.com>, <emohandesi@linux.microsoft.com>
References: <b5d263cf61282b158052ba87bde1fb4a227c0bb7.1696338593.git.love.kumar@amd.com>
 <CAGi-RUKAYoCjmCJa_tBLsHHJfHn5hrJjn22A_MOhbnH8yaSuJw@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAGi-RUKAYoCjmCJa_tBLsHHJfHn5hrJjn22A_MOhbnH8yaSuJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a43a58-168d-4da5-6539-08dbc9905b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tb0hH3K3j9pvjhVxcKcse6W1CzKD7KA8vJjGrYlbNuucFwG4uS3MEPDLwKtQSkjHUQmpu2Mciz5L90iHvyu1vsBi5YrFBB6rET3SHqhetETnXzuPcsvBGlA7BGPD5tTFdAyHWI53hNtQFdXt26cXP5KSiSbE1hWoomLLag4ov/GU0Go8g0dqBCi5bT56CxuPdvGbfqktnh2bCbQ60Xp1FG1QmzJrhm3K3YVeyH2OoPKby1CE8t9UKA9mGYz3WrUwwE45x6FXKlYa3Qi4Q/nPsHLRoc2FZGhVXqJSffBLFeHKF1BW13zLvOSkmEXXRcXItXP5QAiffu06Ns2uRE35MljfbsPJlnmfz3qcm+IG7l2c6AdpkO/4NJjqDA1gVCLw2Q5RGEp3sKTBckgfBEANTfEFlzRmXjVdj5E0+wIJSOCuQCD/U0BkK5KF1hVR+C2TsB7RusMak6zAf0SdwbQhijT80Sp7Lyh+QYyE7WI2nQ2hOI4m8PPwUiAkAF2HgsfNjEhcN79tjCZQOcThpe6xQ6SjTzHTAlif4f0Cc/dw/OCWW32SsT67HIQ+zEuNiwGOCRkjUrrnbY2Y8Vm7eQTZB8RofVw0NyzDYfNq+hQsSJWuwltKQJpEZsME4ZUaY8x3tLgL56u8EJo92LA0GsrEuOGIszd+ZkbgJPM7JIlXDRTQ6cyCUurNW4elVK2qlSjs1Nh8FFfJy2D5WT/BEeaUxpXNt1ies9oqH5PJqZmcBLbOp0YX2xaZ5M+V4Wr6Jiybx3C5bzZt0CuusULBKZ8FbOVaqIp4u2BTOOGHZ9KiZF13d4AUeLbPThf7BmtsVMRS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(478600001)(53546011)(81166007)(110136005)(44832011)(316002)(5660300002)(70206006)(8676002)(4326008)(8936002)(70586007)(16576012)(54906003)(41300700001)(6636002)(40480700001)(83380400001)(356005)(26005)(82740400003)(31686004)(66574015)(31696002)(426003)(2616005)(86362001)(16526019)(36756003)(336012)(47076005)(2906002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 12:56:44.6170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a43a58-168d-4da5-6539-08dbc9905b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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



On 10/6/23 22:27, Ramon Fried wrote:
> On Tue, Oct 3, 2023 at 4:12 PM Love Kumar <love.kumar@amd.com> wrote:
>>
>> Execute the 'pxe get' command to download a pxe configuration file from
>> the TFTP server and validate its interpretation.
>>
>> Signed-off-by: Love Kumar <love.kumar@amd.com>
>> ---
>>   test/py/tests/test_net.py | 66 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
>> index cd4b4dc53cbc..b2241ae6a482 100644
>> --- a/test/py/tests/test_net.py
>> +++ b/test/py/tests/test_net.py
>> @@ -6,6 +6,7 @@
>>
>>   import pytest
>>   import u_boot_utils
>> +import uuid
>>
>>   """
>>   Note: This test relies on boardenv_* containing configuration values to define
>> @@ -61,6 +62,16 @@ env__net_nfs_readable_file = {
>>       'crc32': 'c2244b26',
>>   }
>>
>> +# Details regarding a file that may be read from a TFTP server. This variable
>> +# may be omitted or set to None if PXE testing is not possible or desired.
>> +env__net_pxe_readable_file = {
>> +    'fn': 'default',
>> +    'addr': 0x2000000,
>> +    'size': 74,
>> +    'timeout': 50000,
>> +    'pattern': 'Linux',
>> +}
>> +
>>   # True if a router advertisement service is connected to the network, and should
>>   # be tested. If router advertisement testing is not possible or desired, this
>>   variable may be omitted or set to False.
>> @@ -260,3 +271,58 @@ def test_net_nfs(u_boot_console):
>>
>>       output = u_boot_console.run_command('crc32 %x $filesize' % addr)
>>       assert expected_crc in output
>> +
>> +@pytest.mark.buildconfigspec("cmd_net")
>> +@pytest.mark.buildconfigspec("cmd_pxe")
>> +def test_net_pxe_get(u_boot_console):
>> +    """Test the pxe get command.
>> +
>> +    A pxe configuration file is downloaded from the TFTP server and interpreted
>> +    to boot the images mentioned in pxe configuration file.
>> +
>> +    The details of the file to download are provided by the boardenv_* file;
>> +    see the comment at the beginning of this file.
>> +    """
>> +
>> +    if not net_set_up:
>> +        pytest.skip("Network not initialized")
>> +
>> +    test_net_setup_static(u_boot_console)
>> +
>> +    f = u_boot_console.config.env.get("env__net_pxe_readable_file", None)
>> +    if not f:
>> +        pytest.skip("No PXE readable file to read")
>> +
>> +    addr = f.get("addr", None)
>> +    timeout = f.get("timeout", u_boot_console.p.timeout)
>> +
>> +    pxeuuid = uuid.uuid1()
>> +    u_boot_console.run_command(f"setenv pxeuuid {pxeuuid}")
>> +    expected_text_uuid = f"Retrieving file: pxelinux.cfg/{pxeuuid}"
>> +
>> +    ethaddr = u_boot_console.run_command("echo $ethaddr")
>> +    ethaddr = ethaddr.replace(':', '-')
>> +    expected_text_ethaddr = f"Retrieving file: pxelinux.cfg/01-{ethaddr}"
>> +
>> +    ip = u_boot_console.run_command("echo $ipaddr")
>> +    ip = ip.split('.')
>> +    ipaddr_file = "".join(['%02x' % int(x) for x in ip]).upper()
>> +    expected_text_ipaddr = f"Retrieving file: pxelinux.cfg/{ipaddr_file}"
>> +    expected_text_default = f"Retrieving file: pxelinux.cfg/default"
>> +
>> +    with u_boot_console.temporary_timeout(timeout):
>> +        output = u_boot_console.run_command("pxe get")
>> +
>> +    assert "TIMEOUT" not in output
>> +    assert expected_text_uuid in output
>> +    assert expected_text_ethaddr in output
>> +    assert expected_text_ipaddr in output
>> +
>> +    i = 1
>> +    for i in range(0, len(ipaddr_file) - 1):
>> +        expected_text_ip = f"Retrieving file: pxelinux.cfg/{ipaddr_file[:-i]}"
>> +        assert expected_text_ip in output
>> +        i += 1
>> +
>> +    assert expected_text_default in output
>> +    assert "Config file 'default.boot' found" in output
>> --
>> 2.25.1
>>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>

I can't see any issue in CI loop when this is applied.
Ramon: Do you want to take it via your tree?
Or should I take it?

Thanks,
Michal
