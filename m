Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC4EC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 16:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112AD86A93;
	Fri, 25 Aug 2023 18:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bYaywv66";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jfLbOciy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E81086A9C; Fri, 25 Aug 2023 18:00:11 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6ECA86A92
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 18:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RXPmS4M35z9t5l;
 Fri, 25 Aug 2023 18:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692979208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmshXNXZVGj45k+q3cHPFpwVn8Q/QSuHNy0I5ZjJ8aU=;
 b=bYaywv66fSll6xU049GsNYbfCm6HnkOP2Ya2+pe9SQCJxWiSz7oBlExqDf0GOV/+Mn//3m
 nYd550CYF1UklKEsTcAIhL9Zgm7JyEns9E36I6qQhKTcNqqEa1GgQRmYXPR27PTQ1JAQ/d
 GduroAVHb7xAQ02qZ0LRqyrWKxskOLnVU39tXT3DimKSEIvlKssKFH0huF+umFhYYpFmVW
 pmwdFHnutOUYlmBV2PSoKvjA92qgjynH/qMkfoIFRkPbW2fGzaqLmkIVa99cNryQStK/c9
 MiN5hOAdZK9Vo/ZF111FI2bvzNixvW6spw6JPMSvq3WB4Tpr++/E/1lJPFQMHA==
Message-ID: <eb785092-baf1-1ad1-4422-1c9710e12a9d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692979206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmshXNXZVGj45k+q3cHPFpwVn8Q/QSuHNy0I5ZjJ8aU=;
 b=jfLbOciyI29TQSMDIycKbab8CFKBUIGH/NRtZ5K8XppfWl8MA6bTeYwHcAIGiK4eFnh8Uq
 D75wJCzZQ4nOuPwiIaDJwJllNMGoJsKFCfWTtAx4ws8hDDyqMajEnvGtKTp04thYSWzO6L
 Izhj8RIPIGUHHcYEdv2eH1j9KZb7VYvDur+AURtOW+j3IP8pgUQZ7hqc5IKgWpcHag1shy
 +TRA7rb0Hf3aSPlRrN45TwRmbDWrq1B7WgJDawKtdEcZjp5Ih0dhjQm31uHAeRM4xW5/3q
 pw21RuVEghDB4vhKmmUKvLmfCtFE+0TdQtEis0QB8GcfIB7nDDkfyqzwwW24Vg==
Date: Fri, 25 Aug 2023 18:00:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] fwu: Initialize global fwu library state during CI test
Content-Language: en-US
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>
References: <20230823001652.266215-1-marek.vasut+renesas@mailbox.org>
 <CADg8p95Dtvm++wY=74HVBvHL0cNRxKdSEv5ZtaLAbpp6m+hU9Q@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CADg8p95Dtvm++wY=74HVBvHL0cNRxKdSEv5ZtaLAbpp6m+hU9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cfizf8ee695agpop6n18g1ox549ox44n
X-MBO-RS-ID: afdf3a3bb87e8889cac
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

On 8/25/23 12:52, Sughosh Ganu wrote:
> On Wed, 23 Aug 2023 at 05:47, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> The current CI test worked by sheer luck, the g_dev global pointer
>> in the fwu library was never initialized and the test equally well
>> failed on sandbox64. Trigger the main loop in sandbox tests too to
>> initialize that global state, and move the sandbox specific exit
>> from fwu_boottime_checks after g_dev is initialized.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Etienne Carriere <etienne.carriere@linaro.org>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jassi Brar <jaswinder.singh@linaro.org>
>> Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> ---
>>   lib/fwu_updates/fwu.c | 12 ++++++------
>>   test/dm/fwu_mdata.c   | 12 ++++++++++++
>>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> 
> But I have a question below.
> 
>>
>> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
>> index 4d0c8b84b9d..22bdc78df59 100644
>> --- a/lib/fwu_updates/fwu.c
>> +++ b/lib/fwu_updates/fwu.c
>> @@ -623,18 +623,18 @@ static int fwu_boottime_checks(void *ctx, struct event *event)
>>          int ret;
>>          u32 boot_idx, active_idx;
>>
>> -       /* Don't have boot time checks on sandbox */
>> -       if (IS_ENABLED(CONFIG_SANDBOX)) {
>> -               boottime_check = 1;
>> -               return 0;
>> -       }
>> -
>>          ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
>>          if (ret) {
>>                  log_debug("Cannot find fwu device\n");
>>                  return ret;
>>          }
>>
>> +       /* Don't have boot time checks on sandbox */
>> +       if (IS_ENABLED(CONFIG_SANDBOX)) {
>> +               boottime_check = 1;
>> +               return 0;
>> +       }
>> +
>>          ret = fwu_get_mdata(NULL);
>>          if (ret) {
>>                  log_debug("Unable to read meta-data\n");
>> diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
>> index 8b5c83ef4e2..52018f610fe 100644
>> --- a/test/dm/fwu_mdata.c
>> +++ b/test/dm/fwu_mdata.c
>> @@ -93,6 +93,12 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
>>          struct udevice *dev;
>>          struct fwu_mdata mdata = { 0 };
>>
>> +       /*
>> +        * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
>> +        * to populate g_dev global pointer in that library.
>> +        */
>> +       event_notify_null(EVT_MAIN_LOOP);
>> +
> 
> Are these explicit invocations required? Should fwu_boottime_checks
> not get called through run_main_loop() during boot?

board_r.c event_notify_null(EVT_MAIN_LOOP); is not reached in sandbox:

571 static int run_main_loop(void)
572 {
573 #ifdef CONFIG_SANDBOX <----------- because of this
574         sandbox_main_loop_init();
575 #endif
576
577         event_notify_null(EVT_MAIN_LOOP);
