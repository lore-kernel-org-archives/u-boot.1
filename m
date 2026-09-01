Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D9EC624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 13:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E8FF80BAE;
	Tue,  1 Sep 2026 13:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4S_x0Sh_ZXjp; Tue,  1 Sep 2026 13:47:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788270476;
	bh=83oWa7E4Ms5HakoH1muxsX6LTMZr+9BRzXmH7vjcDQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=honv0kUb/HS5Aq7Qilb7zs/Sn+4p08Y/PClN/B+IKpiWSKtE0kld5cCrSYouSse4T
	 ca78AGZG210ALeLuIatJRGqahsaHzAqG6vdlLJa0aHsFaUIlWbESwjeyWNXg3VVjvl
	 1Vo0dKcQtrusihzVuQ7A0KFHPPMosgp/W6UiaRYVjS2QZo0vH/ACluFLNxzLaecBLG
	 1dXiUrmD/2LK1Ey4OyKcwXFJlER+YVj2oPy41kBLqzVhE+Oa1aT/phduJYitZA7NIv
	 3CG5APnkOGHSnH7RZ2mkSuhFIf0kk7k5I/Geb8XOIpKA+no9x2e0NKrsGH11TMs6mu
	 xVatz4ObE3tXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6A2A80AC7;
	Tue,  1 Sep 2026 13:47:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF346363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B76FE80AC7
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:47:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oFy0HFy8eI34 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 13:47:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XrlP2UJu
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B419D80A70
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:47:53 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso781831266b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 06:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788270471; cv=none;
 d=google.com; s=arc-20260327;
 b=ZRjCCI9jzeeGjcTzRmgltXSdI1Fxo+zZC2QpJ4kWTTWzwaGtZPYwUvF+Gw4Q1RMwH+
 UdYv7mv3kpJ+YCIejr8KTfO1pCHOeF+1vDIgRwFbdcKiEXqrC/0mCTzhalUT60fSO7H7
 BCtKf5jtPXozPGESTeeFhoKF8dp32d33uC+94uzL+mskjBSZVXUw8iTlodOm+gXFbRbg
 PsiatAUSjAnDTzrzcl9r9/MFQxxCTt3OUh2JiQvyQdOW1sONDXbrYe4B0EFxg+0JSJ6+
 4884vu86n3FSBHiiNu4r/0rG/LiSFTkJgO1C81ZhoRoXiHDyYAg3gqCxrYxMl4jXvlvo
 jfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=83oWa7E4Ms5HakoH1muxsX6LTMZr+9BRzXmH7vjcDQ0=;
 fh=IsTTGFp62tpEi//FW/IO6sigZT4kdl8TmlPu2G4eWRc=;
 b=sK47C0FPrz+8h1qNiOWYDxv/R8+1sI8+ZigJ42p8exTWld63DCvdCYpmOK+4myhoef
 f3mjvnf8uELpuOrMIcvfm+dueo1ZfK5u+phKe5XcjfI471noxBcS7zO1fyN8lIluVtOO
 2BtZluvYcBlZbcx70grp5oBSJiSTlnxoDOz3yXJF9mtTv3SdZQ0bNt//tnRWoIdGs8G+
 Smf6JuOQ7MO70g59QEUmExKw3zfcB2dFKWNVrimnLg1yh0NJozZnLsuE0N1J9lkEaI6w
 mFcNnq9O6POgaxpF5LjD+pW+V8LmGkwxbHlpDYlsmpq5P6NXGG9KpG3PaQ2r34TBcGds
 Z2rg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788270471; x=1788875271;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=83oWa7E4Ms5HakoH1muxsX6LTMZr+9BRzXmH7vjcDQ0=;
 b=XrlP2UJuZZXXzSVt4M+3/Y3Djf/9azfwcPKZFBb8BbmgGSjqKBo9JEVvH2vvb5aJAf
 qk08nhoy/9SCFoUaVTr7tUa4rB0zTpLMs+WIhxLFgt7LJ6XoZms7Uj46G+St0GNaPH5J
 0k/44ZdkvdEz9i+XEyEfB8pP+ltpfXzgswZfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270471; x=1788875271;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=83oWa7E4Ms5HakoH1muxsX6LTMZr+9BRzXmH7vjcDQ0=;
 b=S+HapPeYWgDIcDTMuGpcy7/KW8rmYTd+scttVzoLAn0c5Hfq7vip642ZrEXVfiNXqm
 Vc/HQueT+8jlITJnJQXLZcIFpjM7lOQPq5qLFj9SajkorH0lk8KjbQIykt2R6n4DF3Eg
 GfMscgQuLh+A7Wb7+elgzfIhj2TwblbcMWPX7lUz5kEzj0thpf4diIzby21uvsc+jCxS
 JdmUVaxWBvt8FjKFn7qqLTtBVkCxIRG+y1xjzyCtDnMbA/yR9vZzgMsfkQuqLFg9jbrW
 KjTzgGUuZxrty5i+GAkolPo9kIscf213QEWb4c3XHRs033Zi5rSZ+mK4JzPFO21Qc8d+
 +svg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqdI+svoQ7hWxLseVehVUMsLxHOZj33fVnSYCswY2ZWNECxJwbfxcEjSHtdd5g0PwpK2GCdU4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++klw9g8htjG1tYpwsJThR4OxHhloQOLK+4akTfTrQmamnjwsRih
 Mpfe3UwNiCB4tCSxlIQdE7bnikldh/Ggep9rnWdL4HpZmm7+F38J8LRYH976EwerQmSxqfrUXXt
 FdRWnxtvDH+pfnzn9HAKKW1OLw0NzXmKfJArz/FX8
X-Gm-Gg: AR+sD10QF220tIIWWxmVWvgocN8X68hqsMI0rKROHsSKM/cFSdu9+j6PMqAohX7pqv8
 MxzupcME2K8OaW/qZmd9mOjHc68hREg/9epPY3jMKa/y9y1k6PQvxC2mE4dC7++7GIVdTaXKkGt
 +vwlImc/R1Urf6m5ttnBnV/HQpagq+m/U0Q5Vpshbe5WG33pptdVje9Q3d78KO0P7q7VtRB25Xz
 laJiIukGhLGpLbSxoONxrCQ5xJFaQABnE3Jutismj+XzVHBGe/1iviPzw572sdjfTtnqzspsfsL
 anrifMgesmSjDND+2atbkl13zY1zFbvyfsKUqEwsLDk=
X-Received: by 2002:a17:906:f582:b0:c24:c22c:6372 with SMTP id
 a640c23a62f3a-c25b3affecdmr520644466b.5.1788270471000; Tue, 01 Sep 2026
 06:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <nsbob67calfo3hn6y23psz2ornx7clha4pvozyify7a2sicqve@gchdniswepfp>
In-Reply-To: <nsbob67calfo3hn6y23psz2ornx7clha4pvozyify7a2sicqve@gchdniswepfp>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Sep 2026 07:47:36 -0600
X-Gm-Features: AcwNN1Wbl-yJ3b_JG4G5TRAzct8uULblMhqrbrFPFiYnE5wl3r24uRFxyscj3bI
Message-ID: <CAFLszTi+xSGKG7pmjJ+z0KKRPRXht9h81AUx9tX10SwvhNS=gQ@mail.gmail.com>
Subject: Re: [PATCH] bootstage: fix unchecked malloc and undersized buffer in
 bootstage_mark_code()
To: naveen.osdev@gmail.com
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org
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

Hi Naveen,

On 2026-09-01T10:23:25, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> bootstage: fix unchecked malloc and undersized buffer in bootstage_mark_code()
>
> bootstage_mark_code() allocated the label buffer without checking the
> result and then dereferenced it, risking a NULL pointer crash on
> allocation failure. The length calculation also failed to account for
> the "," and ": " separators emitted by the snprintf() calls, so the
> assembled string could be silently truncated. Additionally, when file
> and func are NULL and linenum is -1, the buffer was passed on
> uninitialized.

Please rewrite in present tense per U-Boot / Linux convention, e.g.
'allocates the label buffer without checking the result', 'fails to
account for', 'is passed on uninitialised'. This patch aims to change
the current code.

Also worth noting that the only in-tree caller is the BOOTSTAGE_MARKER
macro, which always passes __FILE__, __func__ and __LINE__, so the
NULL/-1 case is theoretical hardening rather than an observed crash -
the truncation and unchecked malloc() are the real fixes.

>
> Account for the separator bytes, bail out on allocation failure, and
> ensure the buffer is always NUL-terminated.
>
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> common/bootstage.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/common/bootstage.c b/common/bootstage.c
> @@ -175,12 +175,15 @@ ulong bootstage_mark_code(const char *file, const char *func, int linenum)
>       if (linenum != -1)
>               len = 11;
>       if (func)
> -             len += strlen(func);
> +             len += strlen(func) + 2;        /* ": " separator */
>       if (file)
> -             len += strlen(file);
> +             len += strlen(file) + 1;        /* "," separator */

BTW each snprintf() reserves a byte for its own terminating NUL within
end - p, so the effective content budget is len - 1, not len. This
only matters if %d expands to the full 11 chars (a negative int),
which cannot happen for __LINE__, so it is not a real bug, just
thought I'd mention it.

> diff --git a/common/bootstage.c b/common/bootstage.c
> @@ -175,12 +175,15 @@ ulong bootstage_mark_code(const char *file, const char *func, int linenum)
>       str = malloc(len + 1);
> +     if (!str)
> +             return timer_get_boot_us();

Returning a valid-looking timestamp on allocation failure silently
drops the record with no indication to the caller. Returning 0 (or at
least a log_debug()) would be clearer - what do you think?

Regards,
Simon
