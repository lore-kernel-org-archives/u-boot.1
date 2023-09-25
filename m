Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AEECE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB1386D23;
	Mon, 25 Sep 2023 16:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccWjT5eF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DE986D25; Mon, 25 Sep 2023 16:10:47 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE15486B69
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IohveB1wHYBO3psQ5dQE5kecFNkEFG7DIgmImDlyKUzdiTOV9FqUu4GKlCqxJt+WgL0qoXLlGnnVzGJL0syARJCT4ySKxdMR/0+6r/ah+lisx8iLeYfvKW1os+woy2Fm7qO2ICkUCxz/suCIyA+xNICcTmYO3gEpxMaIycG/T4bARNfK1HIU8z94oFEo17JzJ5bpvfjcIhiBMD/m+5NwaEonGZmRwmXa2KBLBqmcTsifFkC4hDE8hVOXcOmtpLqXNuWGGZDhkKQL1GEHrV5AVhcrR83B5e3A5ARsesa93Y5TR83WxSee+cedsqn7g6VZWpyrvim1JCh/5UgpTmNFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47MzvdipK5f32fMQa38MPxxZeizniQOqqLJwjwX5kKA=;
 b=FoZaE7369Mginkx3qg0OfpchkEZg/2gPqtQNG8V7W7WZW6VwlW2fd3Ts/1wB3ybocB9X8WajWxI1c43ubYONnkmx6qi6YNgjZkPpHCIwHyhmdhc2FoeamZeqaXWil4GuxoYbobHelOF1kHUnPK0GaQhgLBkya8T22mGI+PkSBXnaHImavBPpF9RPNVcs5R1teaP8AEwRGPMA4Y3uQu6WYiS/43HaZgIRFuDcScrZtdOZYaT86SfGUSLB0tvZkCMsZFChNzhTqAqD8jumRt011eJSZm0kfmujQ3B0LM8NfhrKcGqqk3GFwpUY3PnoSfu6VZuUHvWnC7Oe9yxQrbZZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47MzvdipK5f32fMQa38MPxxZeizniQOqqLJwjwX5kKA=;
 b=ccWjT5eFim58iGnqsLj5+MNq6hXC1dWIbU1ku6puonJzRTSYtWvKwoUL68371TImZOttHPknAHeQa22mf/og+hKMfOPzZz0lOb4Pc/L+3Gxj51HX9CHsmHp85F61wId8281vXxTwOR5XgU5Zf7rwONdmiSjMFZLBzWX767EveIs=
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 14:10:41 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::ed) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 14:10:40 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 09:10:39 -0500
Message-ID: <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
Date: Mon, 25 Sep 2023 16:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Tom Rini <trini@konsulko.com>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3961e7-e51b-48ee-2628-08dbbdd1335a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqctW678MAAA6XiAuyRoMZrs9jhmsOlqyfv48Yvc5e7h+Fy9RP8EnVD2c6VGrY5l8/S+afDZs8J2XGraF8uFKD5xyAJBVRATmPj3En6FWcOr00HiYyuBPSSHzdMCUztgVRYVXhBi5riKdq+wJoN1bsP4NsmaW7gfQTaDV+XPt+rBD/mtkCzCz831YuskVltQrRmbLdsdKm+Ot+2/3qhK142/ll9+h1sRTbONca24he9CLg7jayePjIYwIfq/w3Cz4qIKoFcRNz3m7DEA67kWl+uvmPGuxYA4IGnzIW+j/w3jeeP7hjJCvlrO/nxu7Lxp0lP8Vw9qQIUvA2C60aqWcU6eLIRj7MX2+XZ1EVCYYLXWTRORvgX7T93wqpLLxHKW77J7g0Q2V7BeTowsO2gUCrY9jjsHIMAvScFrBzz8Re1lcHEbkRGPCaLAg/m5xpjd6tXKVQwpAHARpDb4KFHZYzLet3ED9n8qQOpZyKdLVjzeM3dZ+2CvMA0XUgOM+3pK5zUKo3A8Y4WnTZtRH1EcQkTjwfCkIop0BKadGUof5JMX4K+kO5yD6gRn/14WZhy1MMjDIejG8PmLtgek1n9qxaaM5INzzeiqGOXhJmmLvJZukavPOMipQqCSKWNFFY5ZgAizPdU9XQ/93Fupnyy/0qZqMfVcwtGh47+ZXPFEENfj+UpEbAvEFbNVirKNxIacW3/4ytmUfbfBv8iUrsjPeigR7imVVY07XdKTPChR38xg6kzB3NYk+qhIRXaH6w7hlkKbxFe8a2JbYh6N1Iqu7eHG2QxLhqV9pXF2thlWS2o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(2616005)(8936002)(8676002)(4326008)(31696002)(36860700001)(54906003)(70206006)(70586007)(6916009)(316002)(426003)(26005)(31686004)(44832011)(16526019)(336012)(16576012)(86362001)(66899024)(2906002)(40460700003)(47076005)(356005)(82740400003)(966005)(478600001)(81166007)(40480700001)(83380400001)(53546011)(36756003)(5660300002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:10:40.9480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3961e7-e51b-48ee-2628-08dbbdd1335a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

Hi Simon,

On 9/25/23 16:01, Simon Glass wrote:
> Hi Michal,
> 
> On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/25/23 15:10, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>>
>>>> On 9/23/23 20:13, Simon Glass wrote:
>>>>> Current alignment which is using 16 bytes is not correct in connection to
>>>>> trace_clocks description and it's length.
>>>>> That's why use start_addr variable and record proper size based on used
>>>>> entries.
>>>>>
>>>>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - s/start_addr/start_ofs/g'
>>>>>
>>>>>     tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>>>>>     1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>
>>>>> Applied to u-boot-dm, thanks!
>>>>
>>>> FYI: I have merged it to my tree and already sent pull request to Tom.
>>>> Without it I couldn't pass CI loop to get all reviewed features in.
>>>>
>>>> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/
>>>
>>> Ah OK, well that's fine. It was in my patchwork queue still, which
>>> suggests that the patches were not set to 'applied'?
>>
>> I am not using patchwork. But I expect my reply to cover letter was recorded there.
> 
> Probably. If you reply to each patch, it shows up in the patch, but
> the cover letter is hidden somewhere else.

I have never started to like patchwork. I installed that client long time ago, I 
also have account for quite a long time.

> If you are not using patchwork, how come you are a custodian? Is
> someone else dealing with patchwork for you?

Not really. I am just keep track on it via emails.

DT folks did wire CI loop on every patch which they get. I am not aware about 
any feature like this which would bring me something. That's why I am 
considering patchwork as unneeded layer. And I also don't think that I have read 
anywhere that all custodians should be using patchwork.

Thanks,
Michal
