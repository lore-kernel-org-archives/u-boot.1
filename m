Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DBFCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 576ED81233;
	Thu,  1 Oct 2026 17:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Auk2EAR2QgTM; Thu,  1 Oct 2026 17:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 955D581235
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790874957;
	b=IQzVisN5Se9FtCiZ7haiiR/mPmmBJtuFaIK6RkKoPTXFzLeVH+Cj3ExxCAfm2LbfvIEK
	 gfgu8chtTMPiM/bw+EceislqKfreE9bBegnd386PqqkY9tEGIMkdglyuzPJQX8/busYjr
	 8K9mtq5rWT1b4L2FOf498+ZXLJAEAaTRcmc8x8eoG/m9WhROLEzwNJk0oq8XD2cTPfswU
	 ej/iplwqJNB1d3FKTIxwxy+UXpsQFGH4dARVezaVUGWWjokqGiPY8jt1Sp0phTUc5kUk3
	 +0zf2pDc2M0SZGObXBDpUfYxIFnzLXVNqKRu5plsBMiNG+4823PBN+XKQma7qZ5LXMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790874957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Bxij9HjLxkE26RY9dv9BWBmjS1uYBeK/oWDmUaqu1GY=;
	b=ZR4OJFh4v+yT1GBOAKirm43tNRlAOZLj3AnfSIaLUlUEJ2OYBrVNSMsXhtMp+aT/dCpX
	 g3IyzDHT5QWaG+gLO2Q+DbTEhSN9AgvSrW2hOpOTt4Ft47XH07sCssoC6AeIp1qgid0rb
	 QbiOrqruOVb8q5qUqQHlEdxYEI3T5n7Xk80F/w8y2sSAs1orNjlzMo317T6HOEQBaQA6H
	 DPWQexihylZLR7MiHbeORtLuVq+FSzN6nFqSJ+ETUzCThBcniuMVGPxcD9OTkE5qu0cl4
	 rX4cUbNiVFzvAg/7+QGgv8qAcbSiGORVNdWPYnd57Zs1uNNePH8JhWaWpKQ76+6x7iw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790874957;
	bh=Bxij9HjLxkE26RY9dv9BWBmjS1uYBeK/oWDmUaqu1GY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z5lKzr+im60rhBf1k8QUmRDNqn/FpYt2LPVTfp5gCFWRR1KTTzR369DDk4eeUmeph
	 shgxo8Nc0/ct8Qj390r3r1RrepioyKUBDfd/CAlS64gxPhxVfqLhbmiHq3WeRzwzls
	 T1bHGAqIK/nX04F7GI0zyzj2RCt7K5p0ZAMR3Cchb+XIS+G+m0aTtvGj9o4DKpmXXY
	 O8noKeEpNsQLVLUhY/KbF0kj2/L7sSv6x3WdgG6eIoYU4pEu19mYffFL0OMRE/cicS
	 UPYmv3H704Wn74XKerO04nIIhahxV4l2w0Y+sQuA0T0a04J5F+M266auwDpLNTyWxv
	 hdPDLQtl/93/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 955D581235;
	Thu,  1 Oct 2026 17:15:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80A412E0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66F554052A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gMEzR2XfGbTn for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:15:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5C3A440098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790874955;
 b=RPPOGELFT2MAQpJKBmnb1gwTIKzQOCXHbnB/3KTV8JvmEG+ogGHV90uv5OXnpYC4r0ho
 EcsYYXuG5I0PzsLoC6WwdxRaxya/g531hynxqFtcDYDXqtSxb+FPfTtRyCrE3BLgo/mj/
 GubunPW9GdjkZvkAthUmcgQl5zHtY+xNocm5ukCtnLqawPe5l9CK0Kctvw0bgradAU5O0
 L6tus7SYGXe4QIHi3AS9ZW0Xg6JTWWCDHk+4yQ27iEsh6dgYXfMoA1ILtz3nN/44kOyVc
 Duqas0JKlLlpsG5Mnr4Y4LARVD0N9adGgVzNBApA1kqwkOvREcruvTnjhpGCRIM5AwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790874955;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Bxij9HjLxkE26RY9dv9BWBmjS1uYBeK/oWDmUaqu1GY=;
 b=S3r/FPjUWiKjhD0NNz+Pk4lCZcI+/sc0P3KokaEuQaLIlAGkLci555uu9nTMiKQO/bw0
 pi8vAY0+T7QKFYlWf2ppgyD072Z9TqzusTwKEWKSgRYYL8yVAUh8atlIB+MhCe9QBF/+N
 xxi6/8JpiiSQobLGnqTia7crtpJlt+nRAHJo2Mfa9ryTXWnRY2/O/wBLkADEtHMpSRKwL
 3OU6FRgosmKUEp2wLdXE6ACxuw3I8YHbaZUKk6sXryEQtQ/B8dpQLeTJw+FdskwwkvXyO
 rMdQ3pebqbtw4jeUzOJ9r1w+7PbQ6akOOX64vAhM5H/bYPCm+bzttFfFoRo/FJjFGIQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WFYv+lAS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WFYv+lAS
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C3A440098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:15:54 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf8415866so520552a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790874953; cv=none;
 d=google.com; s=arc-20260327;
 b=fle47CnNzaEbErSpzy+MBF4SnmX78/3KTnbH097Ij1dHMdmUbK/SqHwiFriFYhB0gz
 NZVsliDIKKNdZ2FOPpnaL9mMl19UABPgnz+opYbdOADQRpfb9rRC7Z3ePIk6KV8LIAah
 oq8y/ah/WptfcwTZTBBXA8STY9B9XP9l8sZg5lKDIztVKGQg1pJ/Kgm/9yL5j6eYbxqW
 tUCWCoetUgGnQTy01pDt8wMAsALMnFI5deFJP1lawKBEXdkksmhOV+H0iWMQs+z2HRGx
 BVkurHJqXjYFj5vBvdDFO64nf9Ko+lcZM+GCAlw9HTPQd36f70tcgy0DIDiedohM7UDZ
 rOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bxij9HjLxkE26RY9dv9BWBmjS1uYBeK/oWDmUaqu1GY=;
 fh=d5RzHAoCTk94GUjufTtkWLDb4Q67y8PoOsPUdNg0FAc=;
 b=KuS8FxYbxLkoH6xfhFvPRWrqJCkRWT3I+91zmc++IkNt5RTUxolFJxmn2hpuwkeXgu
 bQu7VIihpEX2stwg2vCemJaF7rwApMmhDQ0Hw2T/BypVr/mveeW6qDVz9mGa2sH1fIkX
 Ao4sKM6nn9wt8XVGwa3LFv+lGUGG5bR6tGt2zG1Mz+TPqFkTJcSfoGnn2+JeedwYSSem
 Q1ww4Td86WqJfSyfjbrCF/JPq8J3y6xGX5LXthvgzLB5B8jlJcJNhSoXACjjSf5QO08c
 4Lk9lIbTMZ8ks/YpXhfO5r9XT4jKSAso246fLNPbp71MVw4tCab7kYTRjRUzN8qKxTAy
 6TjA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790874953; x=1791479753;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bxij9HjLxkE26RY9dv9BWBmjS1uYBeK/oWDmUaqu1GY=;
 b=WFYv+lASfkqPwEhWPrFAVHpmBVNzeFg6Uc3xzD7okmIMr1Ke5WKNi8ea+73GsGNWPm
 BFyy/vqc7ufScjPfFo0S3BI1tyaFVV2U8xsXkpoEkoJYqKIaY84SGlOmZG31syJpoDvz
 CwI10yfGJd/Fkxn4OokX1I/MvfhxVO0sXv5l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790874953; x=1791479753;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bxij9HjLxkE26RY9dv9BWBmjS1uYBeK/oWDmUaqu1GY=;
 b=lGLK1FBrKY9M4SdV58CgSBF9uZ1HSP3r6NwqlS6rpI6ygau0ke1errEyhXcuql+cUg
 UTy+w5rCcTYj7U1rYl4wM3iKQ7TSSZml8y40dTEVvnqVws11VB6RL0h213WSbp9it7j8
 03f8+8eaEe3Ns1YfekAtZ5wQTcAk8YltyB0fJ3O1cOYOGt6H0zSLzhBID5YwIwzSZSOp
 tThQA5NjqJGEv+KmxFnF9yScR54KPWWHoPuOGl+SuFC/+AQ2vZVs4oyC/RPnRTxbgw2+
 jdWjWGvkxBa1e1u9E/fYPeMliFvfTCjW88XYl99AbuccB8ukQODh1cmy47d5pNX/UEfG
 6+ng==
X-Gm-Message-State: AFq9FYL/a3k7Yy4TZzQwyOeKBP3EDg/JCyQcghALNctOVBW1ilLrduVw
 ENimTPBSbCYCHPE9sZ4EkA8s8g82XQ1ECmhbWzJiR2JHuFGc7Hz6KHIAGEaXTDHK8AmDtidK033
 KM7Di313CVeQixj32bkeEtCuPmzz+yEKkkp+UzUhx
X-Gm-Gg: AYBFou0958cQhMMQrznlL2KXvWtKO65IVsR0ElGTV7P6HaPdZmeerhGjDJny/AGiEnT
 56VX3hpil115wDDnkzjbDZ0IFdJO/usaXA9DjbJkJKHB3OBqz2eTdp47/PmUdEz4xAqpenV6Q/b
 s33qvsHLwxImTM+chJSGiloN2EKDArO8qqW90uTtWLbnVA30M5/L1PnxhYqPUU6qtbyFqianP5Z
 5IQzATX1FTcRmjaZqsniFpurAXbV/N08ppTH91R0F7YqEkKe9tqUSqP0hFsNG2KM1QOWR677exU
 g8CWt7g1cWo3IVyrqcV/aR6zheS4i9Wnli2iX4hD6zucPAL+nGIoVxaX
X-Received: by 2002:a05:6402:1f90:b0:6ac:73f8:2e4f with SMTP id
 4fb4d7f45d1cf-6ae19952069mr3853076a12.29.1790874952612; Thu, 01 Oct 2026
 10:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260919202630.3366037-1-valentin.haudiquet@canonical.com>
In-Reply-To: <20260919202630.3366037-1-valentin.haudiquet@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:15:40 +0100
X-Gm-Features: AclHuK8wJw1rhs_RdG6oK5oYw0O6PDYp9quBPgZMy9NHYrzlpmamoUrrvKWyrcE
Message-ID: <CAFLszTistumZW6415UDJ3xw8SvxCoGT6aygyLqtD5uwyaktBoQ@mail.gmail.com>
Subject: Re: [PATCH] video: console: report damage when showing the cursor
To: valentin.haudiquet@canonical.com
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
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

On 2026-09-19T20:26:30, Valentin Haudiquet
<valentin.haudiquet@canonical.com> wrote:
> video: console: report damage when showing the cursor
>
> With CONFIG_VIDEO_DAMAGE, video_sync() only flushes the dirty rectangle
> reported for a frame.  Every vidconsole write path reports damage except
> the console cursor: console_set_cursor_visible() writes the cursor
> straight into the frame buffer without a video_damage() call, so the
> cursor was never flushed and stayed invisible until other output dirtied
> the same lines.
>
> Report the cursor rectangle when it is drawn.
>
> Fixes: 37db20d0a64 ("video: Support showing a cursor")
> Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>
> drivers/video/console_normal.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
