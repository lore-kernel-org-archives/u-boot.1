Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1606CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217B5865A2;
	Fri,  1 Sep 2023 09:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTfCmiWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12EC086776; Fri,  1 Sep 2023 09:09:25 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 481FD8619A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlvQJ+h2QPhRGR7eo6sicEeeSeUcvPNgxScAw88t/Cb3KCO9ihzAqYKRfYbIifRb/44Bqlqo6IfISJSmHbJdtDMKGPVUr5+hPhhLLXtvS271MX48eg5/7p429Yp8Ik2Vontpa+BbqklXaFFEiCx22BImdUN9LG4gb3WYQr0jFu+OBmM3C9MLg+WCr2s46FSGwRXc98NTQ7cH9w4rgC2DZetO2wlEjSp4sWXOeIcEch5OJhpsGEdvGxHX7hMZ8jUAOOYHZeMMg2Zw50qr04TnXQm0BVnspD3450nuYPCorieogFUegvx1KbhhLssE4hJzWcWkOo32B59B306hpoe8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGG0+0rH3JilY0MJ03X2/RzJg0+2I+TkS9T1MC9BRcQ=;
 b=ZZ4XqIXIW/2u+A3IMAtLHLrY+VVZ/XWB8Wx3K///FmeOQsj4j/8xGC9vnzC7ntOsnw4zEQuitFzfMTrPQYhfhWvLNx78klKhNt7AFIlkmDXeAi2L+63iBY0XDf9Sv2TdisnUgAcuxO71VYKJcecfC/WnM3FEiaspq2hTn77QmUVrpY7vwtJRT7JerWjgEzgyL0gsuGrrSfowvLopSdreS9gPv6PDvlFu/GnTzh1Wjlcpz+3uyGKRrD/0HHOYs5EisQKsNAnVml9mXTP1gA7tW6UC5fh3gcyP3rcHmSajP+PZhoKXjtQ/O+ctHgvOsvcKNf/j5NOICM3EEPfd6jGE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGG0+0rH3JilY0MJ03X2/RzJg0+2I+TkS9T1MC9BRcQ=;
 b=DTfCmiWo5SGzuW3WlJg0hEYXZZniXmMvg1c4kAYXlmgn4KULUztDr5l1drzrRVVz6UD1X1QJus5mYCD2Z8TLrepLXFY6q0FhYEKGnpstT7iLP8JoR/njLeS2TrEgrSSR6KoYPw6TTn1BAIExwTvvWDnfh342QV00sGdVWcRWXFU=
Received: from DS7PR03CA0301.namprd03.prod.outlook.com (2603:10b6:8:2b::8) by
 SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 07:09:19 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::39) by DS7PR03CA0301.outlook.office365.com
 (2603:10b6:8:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 07:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 07:09:18 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 02:09:16 -0500
Message-ID: <b48a067e-4143-8cab-3387-e276e900e8f0@amd.com>
Date: Fri, 1 Sep 2023 09:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] test/py: tpm2: skip tpm2_startup when
 env__tpm_device_test_skip=True
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass
 <sjg@chromium.org>
References: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
In-Reply-To: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 19734807-6c84-4375-9b5e-08dbaaba5bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZCDNDvvuSwMqHwe1nNuCOlrRjx8Hc1tW2HNqWNN6iWlHcbjI2gk5GT5FhZJ3cRDOrxbH94fJ5FW8VGYr0qALFHjsk5VDOe4rt2I6wh4waq0jfsN4X2V3ZASOPxBxw/pD0pYfMP40Ot10giXMklXiMOW6AN65fY/UALHl+iskP6SVgOG4iXpYv4GAdrwTy0CN3xvb59BvygrPgFuLhNfFwdkk8NCQgrrABkVT46txCmJtsW5r6q3b+5+g9fjnGA0jfwmCxLbr351bqpI3a5YbdP4LMPxktjtoIjOVjqbVrywRvs4bF1t1i5x9eaHc+azvJ3GVquz5/SjzjyzAcbvvZMNCRAwmLqgCAhH+C8WpcIb/skq0cgrHNCd9xQAjIEQWADng4+TaoBJK0wwDVvGHyx3OK1em5tfzfNYSp8PPznDG8BFVlA4vC2gFJM9yN7/960NFCNFLEeBOU/Ium8VKniF5RnmCHS5FzXjhEk7iUkIxsAz63UZG/x1KE4HR2ibhiFJVwfdfDY2Ie2EizTC46ehNeYn+4rXx965941/+ixNyKbrjkIYIBx4FezI7jn0WWKfBhfAg4Tfeqi1UqhQGdjrRYTGE5R72FIv3FczC9Vm1vYOYllpuzAPDUBLoN/L9bmJn3EoHQyoxy9gUqfkPlVMdNr/CvVMLQ1nmK8kTJjcjEyA8Fx+m0aekfYagbPat12nkAGIj9cD9mzKSSjs19ZIORUz5inoiZACsmPc6v429UidR6eXooJlC6vLBmITY0+PMDbcF+yoL4ZXiHgxq0ojYnhPovSYOnHxkfP/z9lIOntMer6ie/XR4L8XVNImywKnP1PSV+FQp9U5iE0ySA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(31686004)(356005)(82740400003)(36756003)(40460700003)(36860700001)(31696002)(86362001)(81166007)(47076005)(40480700001)(2616005)(2906002)(4744005)(426003)(336012)(16526019)(26005)(53546011)(478600001)(110136005)(70586007)(70206006)(8936002)(54906003)(8676002)(4326008)(44832011)(5660300002)(41300700001)(16576012)(316002)(101420200003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 07:09:18.2763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19734807-6c84-4375-9b5e-08dbaaba5bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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



On 8/30/23 18:36, Michal Simek wrote:
> All tpm2 tests should be possible to skip when
> env__tpm_device_test_skip=True but test_tpm2_startup is missing it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   test/py/tests/test_tpm2.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index fce689cd992d..c2579fa02c58 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -71,6 +71,9 @@ def test_tpm2_startup(u_boot_console):
>   
>       Initiate the TPM internal state machine.
>       """
> +    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> +    if skip_test:
> +        pytest.skip('skip TPM device test')
>       u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
>       output = u_boot_console.run_command('echo $?')
>       assert output.endswith('0')

Applied.
M
