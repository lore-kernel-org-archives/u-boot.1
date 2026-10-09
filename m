Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E63CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CCD1812E4;
	Fri,  9 Oct 2026 07:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eodGjgyc269; Fri,  9 Oct 2026 07:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9049581461
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530930;
	b=plcZkqCw0KdHp+xmxRzBu3zDPKtKCFrEchNgQDk5ww5abIQ3AeLW7z+rStAOLTnqrlaf
	 EpXGOMNIA/2a3/e1oWdAd82NMfoQyJZthP663r49xFUTgcyBA+EIjSSB91b8sjfAyz2Ai
	 Y85l+RZibUwbLJKKSYyBMoA/0/QV4+o5e/49ttxGHTilQVhbh0tHnxr2d8yU9GVp6/i97
	 zkSaMyde170kwh7ygC9R1VYofz4PTx4Q4W1istlZ0wMLxcHtV20WPsGO7CzIO/na04NuK
	 /fRc99cKo35aIgNJ3DHcY6dhUngEp0PuN48OwKybmJNaHdqNExu5ZJFVt1s/C4F2eUg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w++YR0wGa3m5mzHWl9ezFSNwqtCJCoV+5q2Lp0kIuWQ=;
	b=bAftRD+lzg/eAMpSNY+jjCUZV4v+v/ccwRf1m0P1RyiZEmROPHyBoMA210BmzQnl8Vpc
	 4CZoyuG3vef/Iw0SNOAu5+rhtTavlyrYoCgEX5NjFzUS+a8nTP9VGUmJCtRIF2XwN3xuE
	 hQ3JiUnbdxFcZrClDzywy64CHF6aPmT9LEKTwRR5SDlraqQM4mpvx1xBawHhkWSXGtlsB
	 v4vP/XyiYBSxFCagTDoeTmBJ3/zV1v/5Iq797vgC2GacN2RdW8V/VbNv3kG8SxNAmR+z9
	 V67FoGZvtBmSNUxXbzUNb6QHodKNZLHOhb7nN7E9WYtSHDDTL2BNtx1PY5MBfZHpjxQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530930;
	bh=w++YR0wGa3m5mzHWl9ezFSNwqtCJCoV+5q2Lp0kIuWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ItqYySyoZt18Ko42VJeMt5m1k/W03ugu7IFq5Rv1jkkK/uKyY/aOMYMBapI+iAve/
	 1LkOOsw7BDFQehXt4Om3uOJKvMOwS8qPRKbu68UxwWPSHUyrw+pUcWZes+XimiGCQf
	 ZNZJEvS3nsD1w5lUEQrj1dXIFat1r0F1rGvFBeHQpR9BeNtW49A1nyCi3iFNkK4jdj
	 KMuuLyQrUsp7Co7gySC3BYKH86xEZSVlHmzTce62rgPKqSCcgnFIQ+dHftcArhOKGA
	 YsF0jOXO4FLQdjJ0IEyDyWUGrhY5SJyBupRloZZrTovdaI4FECEjmuXQb4ztr+EyTX
	 du3SxgKYyvsxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9049581461;
	Fri,  9 Oct 2026 07:28:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 507D71C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E08C40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIsFfUq2Ydb1 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:28:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4028540061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530928;
 b=jIX2IfGpvsN4goSQ0yKhM8Te0K/l5fZQaJa3N9KTbI9WcTcYiicVoe9vuu3IQdNsuD5e
 IEGYhFnlxN+BuvG7zbjX402oGtKfUAwIGbAf5CpOH2JSvIJdCyqhUr/QxvKXminPAU/nx
 zGzIh7SwmQeca/eUx9zeV2bpV+oVzQy+J881jpIAMIJ4vF6qhItBVtnXjuzqS1bYYwPu+
 CQaklSJ5LDtOf6ze9pv69ft9EHXyMyEizGH4OBcgT4ZzSM+xfRdv2HSFRFc8hgWxHCGl+
 pqxct1mSYQLw7U0QJot7pTs7lLZAwtotvz9NNAxIGa6DhPxSccJOxpSzRLkOhSRs43Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530928;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=w++YR0wGa3m5mzHWl9ezFSNwqtCJCoV+5q2Lp0kIuWQ=;
 b=Td20Kf1wMEpieTmmp/KwjKLY0AzMlM4V7Z+0Q6mSP9CxkQqVSqMKtZ3gO+Ip+WFwF/M/
 lOpUsMMIE7L2gHbQBOLAHiMgN1ZF9L3nbuFjSJdz5gDZAGo1lBZ3SUwvv22HwqOz1RChi
 U7htUuuMYS3Sa4jQYRi1/4Dx3hD9xPBTarmIgcPrNH/K6Us5z/0znMM7eQA5saAFElcIh
 ZuH56/q3zcrlg/15bTOGyDJ0n3t1GVsdchnDp3qA2QGW19sL8QMjX56wNrDOuPY1nSz/8
 zzU+IQXTE9LZDRWY9gc+2UTUsvaI95odwVKhMvCZe7Q2lqFXn4HdmsoR15I08KFojjA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TFjbMRXv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TFjbMRXv
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4028540061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:28:47 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b1762fb68aso676210a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791530926; cv=none;
 d=google.com; s=arc-20260327;
 b=Ay5yDgETwjvlrZs+X+ITcTu3Y8SGpKM0wlzs0r9URZpU3gne/sD8L6ZHGRr8y1CVon
 V5kKX8MMPb5rqAmGxOZQlepr3wJ51jaQt2fXa+og9PJQSMGot91CiKzMFc7zqKfUfkoE
 jsoJGaWczFbdFXIBinmEH2pl1CeSwuRcdr2BkLSUSHbDfnVSRrVT6WZHOf7ZoZBC1bXD
 Db7TCX8fMyIUQimdwJ4bJOmL5noA2Z4nFAJC1yv6ZBZrC5vtARC4SVzu503blzkMGmVD
 JH45josO8ow/JvIZhNFNL9HvPnQe8MnuogTnAgOFeKw3bCKg2X8X3XxKZotSkZill+9w
 Me9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w++YR0wGa3m5mzHWl9ezFSNwqtCJCoV+5q2Lp0kIuWQ=;
 fh=rY+idlteGczeUzoavGev1tPby0OrSo+BQy/feV2dxi4=;
 b=fYWflMviJqenHjW93KM5Jg6N+ssyHHBY1JPTyIytKI4/vTe+LaMJWtSsxnogiU+buS
 kLuxy0ezgQrsNGNAfRWtw7iXlo2O4PQBgPBrOU7QeyPtfTNyYiGKQdCglAhv5DyG+jKp
 IebKVgdZtbFTgGLm3mK53+vExaKD5ES/X6yQGUL0+blrC78w1cokumjzNM6zUzeCazQl
 qLA7Xkvdlo3NuXQGvxF4bwDEGpwd9kQllZd22FKza1TGXXqlJ+U4ngAeXEV9xyzDtqjg
 MSE0Av8vtpFDw3Vhw5caAt/eRHk7CKfiU4SiMWjaDaETzwMlCB/gEbvOLk0/8PfAqmOd
 O1KQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791530926; x=1792135726;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w++YR0wGa3m5mzHWl9ezFSNwqtCJCoV+5q2Lp0kIuWQ=;
 b=TFjbMRXv7q+UEgS4XznTNBoYRd4qBq11F3ZVOfz+wxja906WO5ezc1dd7nOzgxWYgy
 8Fj5Bq7IpV2RSAxb2LNnCvNERswFs4cWwphT5NJmQKoBoXyZw0pgQDDbz4lV68eM+XQt
 MAgFoqftWjto9U4Ex2tMyMQnJ2C+fF5bezchc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791530926; x=1792135726;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w++YR0wGa3m5mzHWl9ezFSNwqtCJCoV+5q2Lp0kIuWQ=;
 b=ZTEN9SQhi4r83k2Jxu38r8x9rlhAibil7Txp/I2SmMhCI0FtjlUyHs8j3iEVmd/Can
 JdtpnyeJnhVJEeDwmBOFe2lLiMmkBREi18+qMezpY57djtzebIIYR564V9eWARqU31bQ
 qrIEsexEYEaiKwFYOngRik/o+7no5CU34ZPRZL1vS+PoCBDlRiHGHMh4eSz/4Po83E7R
 bfAfqu7v4JwmbGJb5wKQWRgBhZvV8VS0wFcSAyMlE34Wv8f7Bf0PdZnDQkL7GU783ST+
 Yb1BS6OtjTDbcggmPq4k6tEcFUHHixLEKkB6jLXbV9j+lNSPLsGRTinPq0T5MvV+HylR
 9/Og==
X-Gm-Message-State: AFq9FYI6Rmn4GVQh4w4cCyK9Z/sCkvrhpQQi+oqoUZCFwFVHhy4I2NcF
 OWrUgSH4ex0qp9XKcX2wS2K94y30bIljfcuAWOjrob8FZgohxnuH099lmTAaQ95n2W9X86JxgRd
 1a5BsdacgOiAjkhAmv2vyu3Lbd7EZEmgzv0BJu28cJSK6ZH8zztpD5+ts
X-Gm-Gg: AYBFou241LxMdomxaQ15wSVKLXTBcCeW5twBDU1Td6EE/1QYcJFff1O6e/i32IjX76S
 vcFTLqPiLvEtbXz2kXcAvnE7ulOdgpO7JOMPvIehlbzOMtY4JsHhlZP7Q0Gf2N27yqdU8wXcNLm
 jwsWpARO/lVcLek5KGJLQGJzwoYTbjWqikfSoWSAPchaFHHUPn00Jkee3QA/KcxUEPaXWyLhMps
 rsWcZGfCrf2kg6qZpNhDsn8j4bzQwwxq2Kes2tB6ke9dAAh10ddVScl83oN1wh2B/BudwoL4Tw+
 /2x9xVQrMGySdHUIkXp7h8iKaod/lCjSA3M3Nj74mazeOGY07SaOWDllAzGo43Os1Q==
X-Received: by 2002:a05:6402:46d9:b0:6a7:ee56:615d with SMTP id
 4fb4d7f45d1cf-6b17c276146mr601815a12.31.1791530925574; Fri, 09 Oct 2026
 00:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-b4-button-live-monitor-v1-1-6a2934e71fbd@protonmail.com>
In-Reply-To: <20261003-b4-button-live-monitor-v1-1-6a2934e71fbd@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:28:33 +0100
X-Gm-Features: AclHuK8N-EnPcpeiWrcLP6VLJEN2EuxHBgqYtYShQv6eDwX4J5YjK9AEo16myJ8
Message-ID: <CAFLszTgN00c+P=DRa2zvOnQNc_Fd6m=_sQSyhXKMbrU-AKg8EA@mail.gmail.com>
Subject: Re: [PATCH] cmd: button: add live monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-03T03:44:03, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> cmd: button: add live monitor subcommand
>
> `button list` prints state once and exits. The new subcommand `monitor`
> loops the input states with default timeout 5s so live verification
> on the device is easier.

Please can you avoid backticks in the commit message and reword 'loops
the input states'? Something like: "Add a 'monitor' subcommand which
redraws the state of all buttons every 100ms until a timeout (default
5s) expires, so that buttons can be checked live on a device".

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> cmd/button.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)

> diff --git a/cmd/button.c b/cmd/button.c
> @@ -53,6 +57,48 @@ static int list_buttons(void)
> +     for (;;) {
> +             struct udevice *dev;
> +
> +             elapsed = get_timer(start);
> +             if (elapsed >= timeout_ms)
> +                     break;

There is no way to stop this early. Please can you check ctrlc() in
the loop, as other long-running commands do (e.g. cmd/mem.c)? It might
also be useful to let a timeout of 0 mean 'run until Ctrl-C', since a
5s default leaves little time to press anything.

> diff --git a/cmd/button.c b/cmd/button.c
> @@ -53,6 +57,48 @@ static int list_buttons(void)
> +     /* Clear screen and move cursor to row 1, column 1 */
> +     puts("\x1b[2J\x1b[H");
> +     puts("Button monitor\r\n\r\n");

Please use the macros from include/ansi.h (ANSI_CLEAR_CONSOLE,
ANSI_CURSOR_POSITION, ANSI_CLEAR_LINE_TO_END) rather than raw escape
codes. Also, the console layer already handles '\n', so '\r\n' isn't
needed here or below.

> diff --git a/cmd/button.c b/cmd/button.c
> @@ -53,6 +57,48 @@ static int list_buttons(void)
> +             for (uclass_first_device(UCLASS_BUTTON, &dev);
> +                  dev;
> +                  uclass_next_device(&dev)) {
> +                     struct button_uc_plat *plat = dev_get_uclass_plat(dev);
> +                     int state;
> +
> +                     if (!plat->label)
> +                             continue;
> +                     state = button_get_state(dev);
> +
> +                     printf("%-15s %-3s\x1b[K\r\n", plat->label,
> +                            (state == BUTTON_ON) ? "ON" : "off");

This shows any error from button_get_state() as 'off', which is
misleading. Please can you print the error as list_buttons() does, and
reuse the existing state_label[] array? At present 'list' prints 'on'
while 'monitor' prints 'ON'.

Also, uclass_first_device() probes every button, whereas 'list' uses
uclass_find_first_device() and shows '<inactive>' for unprobed
devices. Probing is probably what you want here, but a button whose
probe fails is then skipped silently. Since the device list can't
change while the loop runs, it may be simpler to collect the devices
once before the loop.

> diff --git a/cmd/button.c b/cmd/button.c
> @@ -65,6 +111,13 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +     if (strncmp(button_label, "monitor", 7) == 0) {
> +             unsigned long timeout_ms = 5000;
> +
> +             if (argc >= 3)
> +                     timeout_ms = dectoul(argv[2], NULL);

With strncmp(), a button labelled e.g. monitor_key can no longer be
read with 'button <label>', so please use strcmp() here. Also, an
invalid argument silently becomes a timeout of 0 and the command exits
immediately; please reject it with CMD_RET_USAGE instead.

> diff --git a/cmd/button.c b/cmd/button.c
> @@ -78,8 +131,10 @@ int do_button(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -     "button list\t\tShow a list of buttons"
> +     "button list\t\tShow a list of buttons\n"
> +     "button monitor [timeout_ms]\tLive table, updates every 100ms,\n"
> +     "                             \tquits on timeout (default 5000ms)"

Since you are adding a new feature, please can you update
doc/usage/cmd/button.rst (synopsis, description and return value) and
add a test to test/py/tests/test_button.py? Even 'button monitor 200'
on sandbox would show that the output includes button1 and button2.

Regards,
Simon
