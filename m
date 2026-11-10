Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC37606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vEUfFK9z;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Aqa/ywqU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54FCB60A5C;
	Tue, 10 Nov 2026 18:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RF2CQfRuXJ5m; Tue, 10 Nov 2026 18:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7525860874
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794335131;
	b=HC0oxL9HTrE1g0GMuhHTy1EwIs5EapNHaz1fa1oQbzRD76KjEG3zaWCMHAFcmBrmtBWx
	 t9KoYsljCM1kviynDzLVVLaLVjU+wMl/YbBfKYxgRdMBVjE3J4TN2fzXOR90DIt0GsyOj
	 aPSOtFoq7ak40wWLWS7NBZiQDGENzMpFc00hiceYY9TYEqTpGOQhvu+m8EKr9XCWa4sXx
	 ZZ+FTwHj/zxgz+Z5SxaYlctrggaSe6hfHHdBxKzPcDDK/zt/cFeoZGjfr6FVzT2jWgml2
	 H+LCZdJgTgCHgpgimz0ehYB+xm1W79+oRBihlcVH/+xW6tDyuYtcW8/lmBWhAhr59yQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794335131;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qxH/liiR7u0yTeASk+r0DR+WibX5Ms6krht5+s2VRrI=;
	b=qucjDhdWZIKxE+7FZmwtNmNQrFPqO7TCvhBEPtZPIxW0Kqy7Ahav4dabBFdRZfJYmu62
	 Q4l0tnQscmBPA/O8UH96HB7j/73K5J5pVtA8E6M+AfIfqa094ZPoZFay9c2Ua13NQISUt
	 loMRfiv9vTbHuj4hos/2MDGv9oH6VzBp77ownJ0QaQOgpDKjJ7OFFV+RiIxMUEXQSR6a+
	 wfTwpXXOOqi7aRhGtRHZUpAsTKCClGftmC3M7OnxeBVqsBSZbVi8ctsc5ysCgYieXwv3x
	 lye9rl61uPmiAc4ejqdstuW5eOKPW5WYLXDlHeYuGsbO+luFkFZUxiLz7SENgwV4x9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794335131;
	bh=qxH/liiR7u0yTeASk+r0DR+WibX5Ms6krht5+s2VRrI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEUfFK9zV0v9Z+LUT0j5hZDGE7InM8Bhc2t+HZRsiUzrNGb2YpNi8i57YXyVtbMsR
	 1pAobcZ9bj391WXfRi0QyBuH5H5cR9lH8TWFxzlD3eEDSkw+LLe0oQcTVT90VuRejZ
	 tc5hDIXeBFTd8Dly1pjnfYljN0m56zSN5rMezpTwNMLwsyNVb8s2J1Zabgt6gaUveB
	 6sktUrMM8aNflh9R5wFjgtVYNER5p8IOlxOuYHGljecuDnQow9hwQgKZNFkj5+lLKL
	 wbYpNXX6sRIOLFuPZgn2WReI5D3c2v//d95fTXllcnXAAgti5kSD0pDbysIPuMyVsK
	 +r90TDQ65km8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7525860874;
	Tue, 10 Nov 2026 18:25:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BE531FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E57DD4095C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o562Uj1DCZog for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:25:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 178BC4094A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Aqa/ywqU
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 178BC4094A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:25:28 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso577721a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794335127; x=1794939927;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qxH/liiR7u0yTeASk+r0DR+WibX5Ms6krht5+s2VRrI=;
 b=Aqa/ywqURE3NZCb+X1FsA6aY+JDlaeEJpro4hJCG4fDFmLhWBN/om/TmDd/iIng/JK
 iv24kFrs/Ku+TC28zSxfZGKnWk0vwJ0AwT+a7Ncjr00LxowNA5PsC9tIJ71Kwc86frOy
 s7nlFZSocSJJo6tbiXLDAYJoXbHik5gBOUJow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335127; x=1794939927;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qxH/liiR7u0yTeASk+r0DR+WibX5Ms6krht5+s2VRrI=;
 b=ZGqHGTU6rlcTrCTFDeJYWgJN1giA7oFSWDrTqOgXEW2RMpk+PYeEX2QwFqXX2qwV2D
 o9ZVLoRGl5g41TuDi7F2IIPS92ouCg6NqhhbT3HD0pXp9D4+V84CkJ64iBhzSUCyWXlz
 zBvtqPdOuZiaXXRZ/ZwtbrINMCbQkJcyboCWKrBfo/syYBXjQ/L1zAydFLVcqEmnqIUl
 AHv5B37g3F4obAugaqves/jTuDEWoA0v1mkNZuV71FMwj/2QgIK6LsgG8xTaFAdNDLOH
 3tOnaDdEajRuxlHCyx9PNiUSM3W/aKDUMYeZjfmX4C/sh/o/TSt4cp6+M9O0ggAFY/SW
 azcQ==
X-Gm-Message-State: APuU4Z/cYzSes2RVUIbIC3SndanQQ4sQ0BPPpKY1T6lzN80/VfkPmUP/
 g20pfU82OQPjwJ7l1CRudoj3WVKayZzM5pjx8hi4smxPNNS/w5WbSZ+8ed+aHzaY/8Y=
X-Gm-Gg: AYBFou1jUsajm5xceYOtsbrllq7ErNEbbafIF0MIkmQW/9+se3KHWNP4kGigw+bIBts
 uROxx/IZU/ENPGikrTCGwHOkG+wC8+acRc79/n7EUSaw3EuZwibe9kC8MMxpQ5jcPf6nwbJpWTK
 7Td9ervuZIF2TuwVbcW9iBwAopfk6o4ShxkefpzJEIpZsU9VO26hIuvRDjv3SJlm1nEWvWBL6Sn
 x4hUZYUZU0kY6uUybCCjDlHldV3hEGRJFD0y6za11eXfC1wLQoi2qUcY7jNvbvO3PH3T0rh/vAP
 /B1eH79nBr1CFyUkRogE2AoZEaPOTE8SwMYGP8JyuYc4k9RcJagZyitARyctDuMnrOIG7Ypfqh7
 0VBzGUmFuEYrpOZn0bcxi+KwsciV2wnxRNnTGg0iUeALBBIdK+9GYQHcfuK3JZlZbQQT8hIXaO4
 zHkYg0QXhSGfkF/1GjUdD7IkPD+jrPY7dVH96DrWAau6pMz9uGvg+jxaXJQ5hRcHyFANkSpuV4M
 SnUTDOiYgn3xxeud8p5K7Zrzz/SA98Lf4/1xMBNbi7QioJBO9ZAOpTYzu1nA6/gC3VRASNOf2Tw
 UeYrpj0MFf+rLbBZvulcqZxFKi1wm9G+4ydqxoJVTY9X0oyL+nqk9HifgVjAOPqYo8K12zdAHcd
 MHzZYBx0NvLtl4/N7hG62KxdZnTUyj1e3TToC97PSlueQQli7cDNSpmSwVsMbUSDmxL+kHdpeyV
 NzBtJaTsXIPRQf4YwV6+RfUo1FZ+st0g==
X-Received: by 2002:a05:6820:858a:20b0:716:cea4:5adb with SMTP id
 006d021491bc7-718a586cd62mr1133747eaf.68.1794335127265; 
 Tue, 10 Nov 2026 10:25:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718a40b8a9fsm2195485eaf.0.2026.11.10.10.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:25:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd <nd@arm.com>
In-Reply-To: <7fdbefa1-fcc0-47a1-a332-4bd6d3bcd6c1@arm.com>
References: <7fdbefa1-fcc0-47a1-a332-4bd6d3bcd6c1@arm.com>
Subject: Re: Please pull net-20261110
Message-Id: <179433512634.248421.15152040396611982703.b4-ty@konsulko.com>
Date: Tue, 10 Nov 2026 12:25:26 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 13:33:45 +0100, Jerome Forissier wrote:

> The following changes since commit ecdcf9e365df6249a57cd8cc946e7026804ff4ae:
> 
>   Prepare v2027.01-rc2 (2026-11-09 15:52:36 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20261110
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


