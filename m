Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD244C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 07:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3994560B2E;
	Fri, 24 Jul 2026 07:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nGgh0HwQ14cd; Fri, 24 Jul 2026 07:06:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 697FC60AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784876805;
	bh=3Ir3yV+5XZwuqOXNSR3kY0/dLyvZCpgVavsTNzMeaQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRv4ZWSRRMmLq7LwX6LVvnKYrH8diCMNpYpa9HXUcn7K7P8xd1TtRV+tVkCQhDDyQ
	 wvwUPZke6EB4ZFvP64PhMTNySF7pEpJMMKuKd4d+lAxycrFZ9aps/GUXq6J1igfhxk
	 KYFEDDvJMmpwEo/RcqE679+vYKtHEeAAqlMerSjRJNH1SgYkOSP42FR4shiEW+8t/k
	 QiZQzUQOeiQLUzaK8X1zumb3p9oHnFXyzwZxH9eK2EWUoAiO4b6s7v+HZk+66lAxjk
	 GzUjZC/UMFEerskRqcv1x1TQnyzpAN+bBCENMG4SfvKONhRhSRS1854sHj5Or42AYy
	 giUuelhtNaQIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 697FC60AA9;
	Fri, 24 Jul 2026 07:06:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DB20429
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 688D7810FB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5n6Zg7-PBUd for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 07:06:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DA93A810F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA93A810F7
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA93A810F7
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:06:40 +0000 (UTC)
X-Pm-Submission-Id: 4h5zXP6Jprz1DFFH
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Marek Vasut" <marek.vasut@mailbox.org>
Cc: "Emanuele Ghidoli" <ghidoliemanuele@gmail.com>,  "Tom Rini"
 <trini@konsulko.com>,  "Patrice Chotard" <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org,  "Peng Fan" <peng.fan@nxp.com>,  "Stefan
 Roese" <stefan.roese@mailbox.org>
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
In-Reply-To: <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org> (Marek Vasut's
 message of "Fri, 24 Jul 2026 02:00:08 +0200")
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
 <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
 <bAPVINEET6TcWKKuwer8PoGjcZvIrErVHkbVA82oiv74xXvE6S42nAAXkOOP0SjEjlLI7CbPdzaNPdrGMbGV2Q==@protonmail.internalid>
 <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
Date: Fri, 24 Jul 2026 09:05:24 +0200
Message-ID: <87a4rgrhor.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; 
 s=protonmail; t=1784876729; x=1785135929;
 bh=3Ir3yV+5XZwuqOXNSR3kY0/dLyvZCpgVavsTNzMeaQM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mXeYQVaUYK59mOJXKZSwitVf7MfwbKch6HCf8x4ZgCL4v04Cas+9ViZhPpPm2r4pT
 EY3wEQUZ2cqh+74EPsVbXo7MHq5MyM1Hx8PHUMlvQMZmLl+Krvxz1XGHKzgI3jvHCq
 my/227u2323IIquWRKnxFaylsDL1hGrSvEt9fcklQPMBwiUENXxBXJYNilspuGY4u4
 5GMJbXdbRBEiVAEBt8XObQzrB7tKZYCmDQ5TLtnys1kuDZWPD48xgidHg+P/U7/QP/
 6UoM3wCFxkUcd7WqfGt87tbFHQgYQ36/PHV+aj9rn6ySceIupSV+9lOZkDeqvSXZ/9
 y2k7gn7lb/NOw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=mXeYQVaU
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 24 2026, "Marek Vasut" <marek.vasut@mailbox.org> wrote:

> On 7/23/26 10:41 PM, Emanuele Ghidoli wrote:
>>
>>
>> On 7/23/26 20:35, Marek Vasut wrote:
>>> On 7/23/26 4:53 PM, Emanuele Ghidoli wrote:
>>>
>>> Hello everyone,
>>>
>>>> I found that Colibri iMX7 no longer boots when commit 9c1b13b3fd27
>>>> ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
>>>> is applied. Nothing is printed on the serial.
>>>>
>>>> I bisected the issue: booting the parent commit works fine, and
>>>> reverting this patch on top of current main also restores
>>>> boot. It's not yet obvious to me what in this change causes the
>>>> regression.
>>>>
>>>> Would it make sense to revert it until the root cause is found?
>>>
>>> Give Patrice a bit of time to analyze the problem.
>>>
>>
>> Hello,
>>
>> after the regression, get_timer_us() is called on every cyclic_run() call,
>> even when the cyclic list is empty. On imx7 this happens earlier than before,
>> when the timer has not yet been initialized: get_timer_us() calls get_tbclk(),
>> whose value is zero, and uses it as a divisor in tick_to_time_us(), leading to
>> a division by zero.
>>
>> I would fix this by ensuring get_tbclk() returns at least 1 on imx7, but we
>> could hide bugs in this way. However, this bug could also be present on other
>> architectures, so I would just guard against entering the cyclic loop by
>> checking whether the list is empty before doing anything else, so
>> get_timer_us() is called "at the same point in time" as before.
>> Something like:
>> if (hlist_empty(cyclic_get_list())) {
>> 	gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
>> 	return;
>> }
> It looks like there are two topics -- optimize the cyclic run and fix
> the MX7 timer.
>
> I agree the cyclic run should exit if the list is empty, but please wait
> for input from Rasmus on that.
>

Yes, we could/should definitely exit early if the list is empty, but
don't mix it up with the GD_FLG_CYCLIC_RUNNING bit. Just add it as a
separate early exit condition. But a future reader might read that as
"just" an optimization, seeing that the loop would just do nothing, I
think it also requires an explanation. Something like

diff --git a/common/cyclic.c b/common/cyclic.c
index 573e715587d..e46346536ab 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -69,6 +69,19 @@ static void cyclic_run(void)
        struct hlist_node *tmp;
        u64 now, after, cpu_time;
 
+       /*
+        * Nothing to do if the list is empty. Also, schedule() can be
+        * called before timer infrastructure is ready, in which case
+        * calling get_timer_us() before the (empty) loop could cause
+        * a divide-by-0 or otherwise crash the system. No clients
+        * should be registered before the timer infrastructure is up,
+        * so the check for the list being empty should be
+        * ok. Otherwise, we would need a new GD_FLG_TIMERS_READY
+        * flag.
+        */
+       if (hlist_empty(cyclic_get_list()))
+                return;
+
        /* Prevent recursion */
        if (gd->flags & GD_FLG_CYCLIC_RUNNING)
                return;

Completely unrelated, but now that I see a new use of that
cyclic_get_list() helper, I think it's time to get rid of that and just
spell it &gd->cyclic_list. It was only needed back when gd was
volatile-qualified.

Rasmus
