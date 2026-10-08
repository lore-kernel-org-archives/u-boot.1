Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E3DCA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 13:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1549B40AA9;
	Thu,  8 Oct 2026 13:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kl0YGk4D3DuN; Thu,  8 Oct 2026 13:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5047040AB6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791465870;
	b=EWEL5DL/kOIA9tl1DeuUJ4dyIaKcv9EAIQLFo5yVDCYynBonS9+fByUdUsWxcDxtBjcL
	 BRdQr/XaZjohNpHnmkMXpEMvjQwz0HXkhNJ5CZ9ocDmi2IKvMUVPZ8aDyyj6DvbgQBNmX
	 Qd+aIo3L4Q216mNhXTnZF4dTiGqKXZbq9R80a+CHa7+i58BSZTmdDJyALGiinCcSkeeve
	 +C0/7lYxoAj6+zrOewU+dcV5xDsku7Xl2ongFnAEsU+N5LrnQmi7u8sHcTcOQinx/knn2
	 ynmrbVE796dvtt8KYImS/z3DHO0TR9YyYEgfcIFpA+VY8oDnQLImmIixKSmlsNf0sLA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791465870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jq+D8DxUKJdoXRZOuOTqwJHnHyJPa2WFFdhnqVjOfzY=;
	b=Y6Xtz+vwR/6cUKK5KTNS2CIRKYmJOea8B4YqDnYJNgVq3zPw0Qr35DZIudmBYLccdskA
	 5G6+p1M7MsdW2Obg9PMnl8RK++qQO0CYpn2o5zPg6B7x9xZzeZNGbsUM00rMISdOunxE8
	 LeA+ykjpEgbP/xjDrqe3wlCvoNyzBxWsGNlN1TXdzAnVT8l7r6dxqhy8HhiRGriuHqZWy
	 lpBOA481AnoIb0TSJt6FpB1IgqB64P3G3lpJE9amkItK00Ns5R4u/fokYziCQONk7irgY
	 R3SwultfKKXHlFhDiVxlQLiWQP22LU9h8hEy8LJv1Oy2z+rdrAQ62O6Rxy8lYn4WgyA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L9eZzpkP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791465870;
	bh=jq+D8DxUKJdoXRZOuOTqwJHnHyJPa2WFFdhnqVjOfzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/NlX+Av0FLHJUegev8+IpY9731BEHBPQgEQ9/IQQElbHA5BkhcY3cypBGikCorQn
	 +NotYmWHtA5gXFyRg9EXQ5fjmAHU6rQ0Z2L0J8JE2lqf3yJ0xn39RIb1u4YtOmT2HD
	 yj4ZbAdXGy73HprNlrQ2xuyy0JcfFBLEg7VSnQanfYVV6TbYov1+ls5duWRKqICz0A
	 +yGRG1R84pJ1qK2dGQ8nGX82SA2gdScsGYrE+Lqc714sr/RyuQiTypnrpNZHT4UaDD
	 o1atMFu4+buwPIPRAbfXY5jmpoc3/LTZJY4jDN72Ow8aTAkQRT+LfbEUtQzxnq51YL
	 qB15i/zE02Hwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5047040AB6;
	Thu,  8 Oct 2026 13:24:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DAC134E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F52B40AB6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:24:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mz3OTQougxIp for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 13:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6680A40AA9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791465868;
 b=JVPSrb58kO83itTHDxJWOC2b5EdWyIBqxAgtfFGl71un5PtpPsYYvGjNhNuPESvQtYCA
 1hS/i7kz0++LmBxJTWp+nVYV9qpJgyX/0am67s59NKYA7jGgCCplME6Fy5LgcPwEgxnj8
 JmhHziZZRkCCLUyf2TOTKNXiRHOeGVO0uwsyn3kbg+Zx8hordLk7udR0OzJH7hRY/+erq
 6s7AYAnF2MZBnHdv9/a5xoXdihGQ+sXSAcksDMaPlboMUoPnP/P9B5P8u1y+Gh0dcWqHI
 /n4cTGq5Hfrx/lzGUVDWdbvi4Je+aJQglNf1dX4q9T23aq8hn4XIOyedtq4MTWWGobQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791465868;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=jq+D8DxUKJdoXRZOuOTqwJHnHyJPa2WFFdhnqVjOfzY=;
 b=VWZHCdgHrGEKjwHUDUPAWoaEdFLWxHwKx4iRVEDben/h4wsncEsR0mhEsMc8tWScRCtj
 GM49KcdgCePwbkOana7KvME/NvCssvT1YiZ9NrMkm1ASdIin2ofcJyg5Je+4PAkHnZtKj
 I98EcgPF4q3XH8m9+5DZt47z2WBSgW1R7T/L0/DLR3h8T3xjU4al8BIbbJeurqgYJyVOS
 AzeJIGv0+StMyyfvm7fijXx5NDLc4DaD3bJ8r2U0dhY+37H7Ui3cdYUGhmBWLgIu+/kEW
 NEg7386h0lQXRPQofy9dlgi/18gwMPi+LdfKYuf8V1lp2P/UrWXrebvMBu6ZWkax6Ag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=L9eZzpkP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=L9eZzpkP
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6680A40AA9
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:24:27 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso1867480a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 06:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791465866; cv=none;
 d=google.com; s=arc-20260327;
 b=hvmd2BK9SESOj/KOb7niUkE2GFHEZesn+sH/8UEQZw8L/rsJvXwgS1D4BWMZ910Zjy
 f7eNWGlfID5gcktOlpAf82ER4Nfl7Ox5m1oKbkVzZJH4Y9G8zPKI8m/LDezcc+LNxwjp
 DSK8K7eGuVBBxcZFPWEY6ilDBUTiUlKGbwo+9I+z3P4cka1kyLNqMxUfIl+F0X3iT8/Z
 jHdBysf0wCd+9pN89Nt7jbV3Mq1pqldxf4IllmoKC59qrG/qyb33NSfIOE5gb/CIsTeV
 jpQq9Z72voFhZPkLIqygl7H6vH+YDXFe11s2ERVikdv7gt/EhdYKvxeQwJI4MjDshZ3Y
 Tg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jq+D8DxUKJdoXRZOuOTqwJHnHyJPa2WFFdhnqVjOfzY=;
 fh=wbP4qAhiI8Lk/DEUjFBl49BCohTz8UK30uaiUZ9HbtQ=;
 b=DW26M4F0XNLl0V9C0c3+JVRbtKWhl7Zl+YUyOrqslrunRQYgCJ6ZsjiadZ7Wpy+3wn
 papPttlhU51J2HNMfwjoog5x/1h9hC47X+HtJoJa0myIpYM7oveswzid8w6jYgdM5tgz
 D0NAyYBXRA/uRuY2/92//qtOOEaNLjVy/v1DidJayMweR6E8HOi8t4/3oEnJU6zJMk73
 JasDRRsN2kDdE8WlK/jw5+RtqRemJIZO5FFlRXSu2bYgc/6VBIeSqoqzit+bAAFt//Lm
 NqJw9gdBz4x+Be7iEeJT9IeHlddfMjhVVkND4LSi0E5FVV79VTx6avwWQZf60+E7UPlM
 G66Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791465866; x=1792070666;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jq+D8DxUKJdoXRZOuOTqwJHnHyJPa2WFFdhnqVjOfzY=;
 b=L9eZzpkP6aVk4mlYy01wQwrp/y+cDrj5XyTza/3CUI4MwditY6lPZ1k8rUr37REiXJ
 lAh+39qWEKIhlmhPCTqQjnnTJ7r/jCA3WfKveQ8nsaAYnzCIbKlxnks2YqDj4RK79Bnp
 T7iCxVa5qQWphjFDXbchUWY5yP21G9mFszmnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465866; x=1792070666;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jq+D8DxUKJdoXRZOuOTqwJHnHyJPa2WFFdhnqVjOfzY=;
 b=zXUmID1qERPna8snWXiSdhifKxR4M9HAX8HfMNxSOwNTvsdcihJkrYSL/z0qsE4+BH
 VSfpVc48VJMVbXMKtPbTloPrhYW92bvHKFB9VtLSKSE9L11unLfkXnI0K6iu4NiW0nx6
 Fnky5ZNFZ1JnhqQbqX5oNfr735ghxoq+yfggKaWYO9N3bUMhHLS/xXncA9UduTeg+zhJ
 uTrEY5lYmsU/z79GSAFLsz9xcVaGxt6PZt0QJFs6haHO0eTpCeS2MGOjGo1Ql9C/+e1q
 scEDBmmqlmddELZwZGUc8XfcBahNbQibuh/X+625zGeIqi+MaJNUxeWqDdxXJpr/ZiTO
 9Pjw==
X-Gm-Message-State: AFq9FYIwcT1NGIXW1hF2IH/t2AgbWuPBp/X8aiWpR/9HTRjIZtRAyL1I
 swCosfPpb8FT+6oHEWIvgC1zQp9uQR8DUnNSCkMHpX04/zFSJ4Y5R0jNECek2hUDHNW0DF6gGwF
 ExlmP6fL2ghqTkixfsZvYjwk/B++nNEplyAvjdqRdpZCkJ3fge4W3brp1
X-Gm-Gg: AYBFou2z8B4XAWUQklATXlY+oMMABK6vEeMW2Z0AjNsexNnf2PtQCVdC7J6SOAjpjaJ
 /C0yPX1TqLHTj6GrqrOdFlOa8je0QLfSFEH5TqA0U/JiCoFvqTMLL3f1MspUpY0cbQvq90QvAwD
 p/t9dgQMpTgG9v1USQhi1paeZV3numofbrOiF37DIChFOKrJuJgYnx7yln67JqvZuB0UtmxNp0g
 dy2iwQF9XtOZPiOvO6zVZG50R/g8FDdrcysIz/4rgiXJeprMOp25l2+1CAJl19Y5y5mcnQapRYj
 4nZBXMWqM3r/khn9s6b0wIuoZPC48VSEQaIcRi/K35O51fggHfJfIA==
X-Received: by 2002:aa7:c981:0:b0:6ac:8181:3194 with SMTP id
 4fb4d7f45d1cf-6b011cc194dmr1493986a12.15.1791465866035; Thu, 08 Oct 2026
 06:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-3-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-3-michael.haener@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Oct 2026 14:24:10 +0100
X-Gm-Features: AclHuK_vo-In3w6E1jykTF9ZWVaQdiYlXNDURvmBa8bgXeeXWkKy4bvpp4GEclI
Message-ID: <CAFLszTjG5OmXN_2oGHyXx7owK4QoX=TmpRwQdd9K4KHhmpHNAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] tpm: Add tests for CONFIG_TPM_AUTOSTART
To: michael.haener@siemens.com
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
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

Hi Michael,

On 2026-10-06T15:52:14, Michael Haener <michael.haener@siemens.com> wrote:
> tpm: Add tests for CONFIG_TPM_AUTOSTART
>
> Enable CONFIG_TPM_AUTOSTART on sandbox and add two tests which send
> EVT_LAST_STAGE_INIT: one checks that the TPM is started, the other that
> the event does not fail when there is no TPM device.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
>
> configs/sandbox_defconfig |  1 +
>  test/dm/tpm.c             | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> @@ -395,6 +395,7 @@ CONFIG_ECDSA=y
>  CONFIG_TPM=y
> +CONFIG_TPM_AUTOSTART=y

As Ilias says below. scripts/event_dump.py lists every spy in the
sandbox image and test_event_dump.py matches the whole list line by
line. A new EVT_LAST_STAGE_INIT entry for tpm_evt_autostart() now
appears after install_smbios_table(), so the test fails from this
patch onwards. Please can you add the line to
test/py/tests/test_event_dump.py in this patch.

> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> @@ -197,3 +200,44 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
> +     if (!IS_ENABLED(CONFIG_TPM_AUTOSTART))
> +             return 0;

Please return -EAGAIN here (and in the second test) so that the test
shows as skipped rather than passed.

> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> @@ -197,3 +200,44 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
> +     ut_assertok(get_tpm_version(TPM_V2, &dev));
> +
> +     ut_assert(tpm_report_state(dev, buf, sizeof(buf)));
> +     ut_asserteq_str("init_done=0", buf);
> +
> +     ut_assertok(event_notify_null(EVT_LAST_STAGE_INIT));

The handler only starts the first device in the uclass, so this test
passes only because the tpm2 node comes before the tpm node in
test.dts - sandbox.dtsi has them the other way round. So you could use
uclass_first_device_err(), as the handler does, and check that it is
the v2 one, or at least add a comment saying that the test relies on
the node order.

Also, event_notify_null() runs every EVT_LAST_STAGE_INIT spy, not just
this one. On sandbox, install_smbios_table() allocates a new
4KB-aligned table, never frees it and moves gd->arch.smbios_start to
the copy, and efi_block_device_create() binds another device. Other
tests won't expect these side effects. I suspect it would be cleaner
to expose the handler as a normal function (e.g. tpm_autostart_init()
in tpm_api.h), call that from the spy and have the test call it
directly. What do you think?

Anyway, so long as this passes CI, it's fine with me.

> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> @@ -197,3 +200,44 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
> +     ut_asserteq(-ENODEV, uclass_first_device_err(UCLASS_TPM, &dev));
> +     ut_assertok(event_notify_null(EVT_LAST_STAGE_INIT));

tpm_evt_autostart() returns 0 on every path, so this assertion can
never fail and the test checks nothing. The useful property is that
the missing-TPM case is silent. Please can you add UTF_CONSOLE and use
ut_assert_console_end() to check that nothing is printed? A similar
check in the first test would confirm that there is no 'TPM startup
failed' warning.

Regards,
Simon
