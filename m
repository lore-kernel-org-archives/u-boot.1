Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D5AC982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 033E080D8F;
	Sun, 20 Sep 2026 15:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAnIkiCzR1WF; Sun, 20 Sep 2026 15:49:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3FD5B80DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919362;
	b=ibSkjzFxEr72uyUNjsbFrRToJrdDx4+DB2I7rnGAdU9kTGcLEVtX0NYqeUoTmBh6uf1W
	 6KcOf/CHtw8lUErb8nvwFAHUL8WBLyw5ax4f7nlB+zOx+jCmw1blqaZno+p1VCsgjDwFe
	 U9kFapaXsJ8TJKIH03Ns+6myTxBJwhsyiQwsA5A7CfaWWZE9A5idLbhwbac9FAQe2ZH1a
	 /cJxc3JkwfKK2xTmK131BlTYYtTJuzCkjiZjSEXmAo0UTkdHZ9jm/+dJCBnkU9sza/ast
	 4IoPYOMJFSz9HhvdJ5PCo39Hli7aOaZAvgv7Wgw1eX3eHo02uTvbbk2boZ0v+KC1ypg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QfDJvcBbuTQ/WtKjqLQmrt6OZxP2oXQHW9VfwmwqJUU=;
	b=kmX13hhXYXu6M/rW7482Ywyc/YINb5VTuSrj0In1oxK58NqpV8nY8dbWCQ5C/dJwNfzZ
	 hn/SVNz9WT5zj4UY4TLI4BqQ5OrTzR+GmFwHRL4BKbFVNNhNBIIz47YXQ847PjY5tVvHb
	 nHYHVU0Q/KNq1zFSTRuRtv8BMWodXKblQDCbeQGUrLNK78PS44OOJN6TZHzOB18JH9jTI
	 GFGWskmNjRhpxLqAl46LuCLtsvK1ovh55fMzT/aDpjuMV6ZzYF8iROQ2p/jtHaAkLq+dU
	 CbXmywX4XaYP384xwGuGQ8v9e9NzwUGaZsXf447W4vYdwusRxQy/yN7kOAVAr7OFhZw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919362;
	bh=QfDJvcBbuTQ/WtKjqLQmrt6OZxP2oXQHW9VfwmwqJUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sw/96RVAwxdwM69l9WKR0H7U+X7S1Z76QLMFW9KrMpXnYOr+hmy1WValBfKBx5YrX
	 m7397Qv0SkbEgUw5Y6rKE4nGPFrn6Tqs98u8Ucg9uQKJMy2toiEohXDJcrBVmV04I2
	 nhIPx+T5jdEOSrljCATrkhDRbTF8/CP5SpXh5CcL9Xblb0zgDMyhJYnC60KdSY9QiP
	 EcohqZPbHDAe9hAMG6m2DjgWd7FtmiVgxiKSxY3+gRQ93DoueNOJ/ya5HI/M6angQb
	 S25ULquYTUu2PzxIlKRMWyCq6ocV6V8TuCBgsT3/Exy7kKGI8NiI4HPc8nYdbf7tM9
	 Ycfhsavm6a98g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FD5B80DC5;
	Sun, 20 Sep 2026 15:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8162724D
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 09:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 614DE408B7
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 09:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61iWtFYUUCEZ for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 09:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA3C840852
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789896656;
 b=A3ROdBgc1gTj0FUQ2M15Y2Ioh5AIiCyqE16dDGGtLXKNqXd4jDKrWg/S5inezuQO5ggt
 hO6F5u9mOQERbAV0yhN+6oFLBY6mCa92MC8HMatorfW16LXPqUySCzLYYcFFVqZ8m4uJa
 qDBdV+1WV4OCMr1G+R67Z6HPNSkd26srnZbjODVQ0qAJW8b3h0/67ydzXOKpNFpCf7Nnq
 SisoBZ1OVPw7Mx1il8G2sbEc8J1Z3ASR7nSNM9Kze647ttRC0h6yYa04ie/89vf+oZrwo
 nW6BIacjI9/o1/XTjNKmncx9G8s6PvKktaZPTLRzyS7bqAW4+Gc932I+jwcrbzLaCcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789896656;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=QfDJvcBbuTQ/WtKjqLQmrt6OZxP2oXQHW9VfwmwqJUU=;
 b=j1iQZyCoFp6SE7nnRs+oRqemqMz87vytiC+nsyMicRNUKFCcAL/DX7pNZ4HQ4N4m682R
 ApC2UR5AczgDbqsZTZr+6QgR24OMDtrVmE9pt71BkFCTj4yJjpBHrx3PFkqMM2skdL+Wk
 /gd0ZGtrK2iLbvmOjz7sOnfSjpmFwrIOnH5x+t/bheJP17TIAi5p44a38VhITmJOmRMgS
 940+M0+rwyzbkNzx/nNgSc+e2J3okvWC8W75HIGjnibN0JhH4raE80AxEFtNROo734Oea
 io09xsKCYxBnPzmRDi4K5mFdow1v4cbHRgbb52PMuPG5waESZffZzV0a4lJ3zkTQAWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=fiuXwz1n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=valentin.haudiquet@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=fiuXwz1n
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA3C840852
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 09:30:55 +0000 (UTC)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 640223F2CE
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789896652;
 bh=QfDJvcBbuTQ/WtKjqLQmrt6OZxP2oXQHW9VfwmwqJUU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=fiuXwz1noDgtepvcntvmZ5+HpYVJ993TYC4N29Z2IeCpf4hZLq6ifbiLFuEtmg3+E
 otDUypDMlXEqULmgS7J9kE+fiqXMCETJKNCbuFkb9Iz0HY58a01VTmA28jZa6NHP0s
 vStzf/YRN2LQivg0ocHLBsE8FLhHfYIBJCUBaznOsJZirIaRSBg2zG9SqQcFLLRIjf
 f3bVcaxkfQwLeCFZwU/JnFchZ4eGdPVtaRoimGtaxYB0QV320NAFSIP6PZJU6ZLECQ
 LAawifQr/nn0kds9bGIm9ujrfnFGCqeEc3gZXqYf+DaJDYB75vM2PYnfqndA89IHsR
 EGfaI/aYQDb1HEHuhWg2ux8wjMmVnRII0LkHI//KXDAcIsphrbR9APcSlPzl4+OyeF
 5BRiOLO4tRbRq8OgYIHRGbxpHpr1hyGad0PQXe4q74kmSfF9/Qq+IQsyE6Jf7orSzk
 Gtvh63YAq8gBh0LP3CwyoZZszws7cLya+mcGT6ZKRgJZgl0SuCnhJhr5v/e7Va+Omm
 Ll2gXDBl0+dOfJ+bZcqLs8d1acypuuD15esZlM4L08sYYFGHg/861hJRzc0J+etyhc
 BqxmcH8TaxbmEsKQnzdK8Wu8x/hU0WShDZAMZ1Ofz4t5+iH2rUuUd5QamKV/bxCEMi
 TDG0EUvN17Zqhq5CNUYoG6Xw=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c29476212f1so167992766b.1
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 02:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789896652; cv=none;
 d=google.com; s=arc-20260327;
 b=C3av5VRz3DXpFwlgCXuCd5lNTAF5trT4cZLpePU0Q1SKpKXfJmrKw4mYgcpVx1wk1/
 puXNZlZkF/qKDOH5q/4CUK/2boTbyrWvWWck/EJQaB8+x+JVZdWlSPVk5jCv+IW+Pa9U
 qmTfRyFUX/0dpfqJqG61VnPq6hurXtNrW7A3CPPUNZV2nRYt98Sk23+mSEufq9faOBa+
 qRpWA0l8jJf/qs5v9WZCMiUNN5bAyPF+AnogptpXckeUycHyZwKZm7JGNs+zllSM9WZl
 LFToWzhT8WIYlKF5qM6rAodgrtJUD1w4fzZe6WFJB5/dyWzjl3bvaf1Fz67gn4EAD/W4
 SpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=QfDJvcBbuTQ/WtKjqLQmrt6OZxP2oXQHW9VfwmwqJUU=;
 fh=6FhNX4EifmO17+HlZAt4SczR68t//h0kvRlBfULoxBY=;
 b=Htrw0ZE2wv4wn42ORsrZ/KUQaW/yC+nnmQWTht+JdSRvpuyvsXKcR6Q3Wkpe4hqzOI
 6LWj00eW3rF5TVz0ST9ilHoRDDd52DCamg6HxavQNs2uuyiZldJyeahRWYMbLGYBParg
 fMYhjWB1d8HC7Hqw8rvVQ9LKQnsQWx4xztSBrflOnNOxUCmqo0N2ty/2uXohXW07cOBV
 OXzCgd12JVP3543r/ynoUdnQR+72b1/5ppEwDpQhjDpiebrYm0pdvLs06pLSRoVFHjS1
 etqCygTxwlMC3kFFQFjn8wymOqI2X+bh1R4FfQ00ae+gXFUVaof1w521rbtFc9vntIAe
 Xo4w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789896652; x=1790501452;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QfDJvcBbuTQ/WtKjqLQmrt6OZxP2oXQHW9VfwmwqJUU=;
 b=MGC0JepJ4kzOY+Sn3UkLUe981GFKZUA2J5bCJ2dnAaWGd8MvAHJdPWQfmGYVnSD9E1
 H0RU9kT0c9GsMj2rTM7XEPFNa46olT1CKjVYS/i2AY63cyh2G8B1mLfNWMIPfa2uEr91
 9woy998VBIT+w88L+d0NvHVi7kPDxCqmNCgZOh+5iTApC7ugBfbL8Ztjd11UZ0gQYRdj
 Oe/fYloZNBw7oOWg7iMqccfo4rYL6Z6cTHSM0y86sTb/ZOkqdkvjUtrmKpQcO4G359q+
 ByMWN/RZk7OZzpSoJotMgXSzktSpWV6HzbmBiEo+wyspRnNgh8px1b3IWLeqTvT5fXNX
 Kq8g==
X-Gm-Message-State: AFuF++nxYauG9tPqQS5iKJi87TnIMLBLv/ihHmnLNxOB0Fh9mVUv7PaE
 stZjX6gHbaARYH2BUOLtdol555PF2y06zvv0/V0O0FFl0Rji2ODxaCWATdoVwnjsEQ/9jcmuW1s
 0rPuqwueoYuVc++PHCdes9k9UIO5Eh66KC7Aa58z8EqMLz6BHTEQi3nUgUv388z7pR529PIhNqF
 fOsicQ1tf5CqrN3vdb38AzalidEfJc4t1sgwQGWtmyau4oIz76zNfy+4fOf2n3
X-Gm-Gg: AYBFou0BrL1etSpy1H+2QsFD+0EUcJ6AoY0bLy6S90oPF9XEoFg/QZAimpPDwhWiP+U
 nEpVPij8x3qGN94Gxgc3B405p93B6kr9IsrZH9tSxdjzQRfyw3wcGZqtMJ9uP2KtJiLt94FD8V8
 uJ6L0zO1Kxndh08iCf6ZBqwckLARmyDIdkjP6LvqvzKuuI4Asl6WFPY4w/
X-Received: by 2002:a17:907:c5ce:b0:c25:cb7e:1cc9 with SMTP id
 a640c23a62f3a-c2a1569a4c3mr597994466b.7.1789896651966; 
 Sun, 20 Sep 2026 02:30:51 -0700 (PDT)
X-Received: by 2002:a17:907:c5ce:b0:c25:cb7e:1cc9 with SMTP id
 a640c23a62f3a-c2a1569a4c3mr597993866b.7.1789896651699; Sun, 20 Sep 2026
 02:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260919215207.3832887-1-valentin.haudiquet@canonical.com>
 <DC5DDDDE-98F7-426F-8461-028C7403C479@gmx.de>
In-Reply-To: <DC5DDDDE-98F7-426F-8461-028C7403C479@gmx.de>
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Date: Sun, 20 Sep 2026 11:30:40 +0200
X-Gm-Features: AcwNN1W2koiGG_XLmShxTGK9OHMG8QbpuSfd2N8EkxEWXlu1tnZUp876Dxk9Ubo
Message-ID: <CAPEPrSM8fLkC0xHxrbxeob76jJrpjzebmstYBoV9nHv7KT81Sw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: efi_console: find vidconsole when stdout is a
 list
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org, ilias.apalodimas@linaro.org, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

Hello Heinrich,

It seems that most default configurations for boards in the tree are
using "serial,vidconsole" in that order. I did not find in
documentation that the order of the values was meaningful and that I
should put "vidconsole" first. From what I can tell, this is the only
part of the code where order is used to define one console as
'primary'?

For my case I had that same default config and thus the serial 80x25
default size was used, leaving the EFI output confined to a small
region of the panel. A vidconsole always reports its exact size and I
thought this would always be used to determine default size when
present, but I see now that this was not the decision you made.

Perhaps documenting that the order of values is important would make
sense then? Or thinking about making vidconsole always default when it
is enabled?

I personally believe that if a vidconsole is enabled, it should be
used by default to determine size (which is what my patch implements)
as it is guaranteed to not fail (vidconsole always has a size) and
when enabled it feels like the thing most users will care about; but I
guess that is up for discussion.

For now, I will change the order in my personal configuration then, thank you.

Best regards,

--
Valentin

On Sun, 20 Sept 2026 at 06:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 19. September 2026 23:52:07 MESZ schrieb Valentin Haudiquet <valentin.haudiquet@canonical.com>:
> >query_vidconsole() matched the stdout environment value with a strncmp
> >against "vidconsole", but stdout may be a comma-separated list (e.g.
> >"serial,vidconsole"); match the substring instead.
>
> Hello Valentin,
>
> The string match here is used here to decide which output device defines the screen size. If video is your primary output, you would place it first in the comma separated list.
>
> Could you, please, explain why this does not match your needs.
>
> Best regards
>
> Heinrich
>
>
> >
> >Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
> >---
> > lib/efi_loader/efi_console.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> >index 8d076058280..85f1a9312d9 100644
> >--- a/lib/efi_loader/efi_console.c
> >+++ b/lib/efi_loader/efi_console.c
> >@@ -344,7 +344,8 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
> >       struct udevice *dev;
> >       struct vidconsole_priv *priv;
> >
> >-      if (!stdout_name || strncmp(stdout_name, "vidconsole", 10))
> >+      /* stdout may be a comma-separated list, e.g. "serial,vidconsole" */
> >+      if (!stdout_name || !strstr(stdout_name, "vidconsole"))
> >               return -ENODEV;
> >       stdout_dev = stdio_get_by_name("vidconsole");
> >       if (!stdout_dev)
>
