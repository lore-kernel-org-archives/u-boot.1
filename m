Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC75C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 17:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E980D605B0;
	Mon, 21 Sep 2026 17:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3zaCLPNTNha; Mon, 21 Sep 2026 17:32:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43A4D605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790011938;
	b=fyLdmcX3Hlgc3vnY7fpvgIjaDB6MbhHcbYaHHjeX0RooiEavPTHJbELEWGCBtA0EnxmE
	 j9sY1ghu3nq0Rb3FiPEH/1tadKP3QFWUPG9B92OKDjgVILyAdLwnkRf001Jvyf9+xikZz
	 bYCjyZMqhoqA06xP4j/PeR4EGrIPA8aHVXZ/kuLyezSScqpzGWwRFpNGdPx8G1XWS2/p6
	 AAnzacwuYqiffQ9adLxi+1wNWe7X8LOu1KLDChi0aytf/n67BfRLx28wVcXwYJ0lhItNU
	 tJXkAhHR+47YgaoMBkFmXVrEK8KgDzOmy9/SIycFk0C7MO5rIY0Hrsl5wg7Q3TLmkRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790011938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rupxDw2uya4FdwitRYgTeS1CKciwORfp8GgH77Toe28=;
	b=AlUPfQbXSHfFR96T2uFyEBB5GJ1z+3+Vh42d1nB+Wj5lTOYfxKDx+aaaZO7DokL/hQgx
	 S7HEKUbnxeTGa+S1hF5puqhn4OlzJqnfEstEO3SsB/21ukBGo1mm9CXWf7JLfB9SmNRYE
	 lLOWDbxr6kyhcWPh7OrP4AucpndowkYhy7KGT49tXz/womR6fBotMWCaNJAcSB74knMlg
	 HmUVm4a4fhZCKFuN+40G4RbLOQ5ESCaGmf5++I4ebHMXhcsUknyXVi66i8IS90OPmws2i
	 CorWzMSlBma0pwmKlSi7PRuTXAQjVVp7RyIC+oh454+WtFVlsOB+XQIB6HxkR/N99Mg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790011938;
	bh=rupxDw2uya4FdwitRYgTeS1CKciwORfp8GgH77Toe28=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TGSMsYKz6PHmmLLiEmyJyb+z60BtYpDdELnYSjxYCW5RMYOjfya8lEJ8qVTbEgns2
	 SDLGlQ2qZrhbfAdfcg3kdic0FhUOPI4rzzCvgH5HPfywi2hyGKOZfTH/yOWbjRAfnI
	 GcbXnIANpU+HF4qu/APv/bjN5Jhtg5goOAXGARiyfMsNUcZX5J96u5zbmS0sV7AxWK
	 PtO3+tF+pnoxu5p/9tox0DhAAnLmDusAmRaz554pAvr5PCHYjEOxS0tvZ18zHAziH3
	 mPid8GfAJHtTP/FPLn6UEmiDNVWepOP/3hzmdTH7cBXIbKahXxdifOJZ5kdsN2S/zI
	 mszrOHfcnKXTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43A4D605E9;
	Mon, 21 Sep 2026 17:32:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91EE0224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83D8E4005C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiXVRCQ9z5Wf for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 17:32:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D125F401DF
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=74.125.228.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790011936;
 b=hnAFUmuEUB2bRXjNWqUSEL/fzJG3YHmm1VopAP5lO0xidU0DIvu7WE2k/yvOzTeSBHvh
 1yILH0/lpQMT9De/LnoiFgulO+6pSkP81GcLpJo8hMMvUc13mpZCFulpHu9yegAVLozh/
 gi1gQVTxFvKtKMPbdY1vTZ0mMA0trJz6aboxkXsT0nnqJd3NAiiExOwSpIoQacTz7DoKp
 znuJEMYQkEzbcE1UU1lr5Nk/UBL1QBdxUcUcwuWpEK246ijNi30s9FVGJa1qLU1f60OP0
 pjyvphc2kX75WkVhFZgyPaeJNAkfU/h3DMzLQA/H2dbsE4FdKV6iUzWULlVdU62ilKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790011936;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=rupxDw2uya4FdwitRYgTeS1CKciwORfp8GgH77Toe28=;
 b=A2IQ2MpBIcNoNyVG2mln8Xtepb9wWBvGz29RTWQb0nMcY7xzEVqawJjCJldhyeMRkZXv
 mbNFl2uZe8xp5ib1GGNRc08LRGn1MON8GuPF6lOl/webzccW3+jvnvxvaigOQjCGKu8kG
 LHouUCTHXM/w2mYremzqixWo5TC2RoHn9lDJ1ZpawU4cDYEVGrFAfg13GvHhN0CjWcZ0f
 LnwvKBZ9E6WJox/4is/jGYBWJa3jSedBk4q3m7VRiGX5q/cLZKdjs4JaiB6s5b4sWz1Tn
 KZn2pKnNQmm3mljnWtwUw5UGTZEq2DOvfKCsStS1aFCY2XoTSbsYGLJnBCBDyMiGEBw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CWyHs7+l; 
 arc=none smtp.remote-ip=74.125.228.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.228.20;
 helo=mail-pz2-f20.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CWyHs7+l
Received: from mail-pz2-f20.google.com (mail-pz2-f20.google.com
 [74.125.228.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D125F401DF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:32:15 +0000 (UTC)
Received: by mail-pz2-f20.google.com with SMTP id
 41be03b00d2f7-cc1cebad4afso2343374a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790011875; x=1790616675;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rupxDw2uya4FdwitRYgTeS1CKciwORfp8GgH77Toe28=;
 b=CWyHs7+lMWBl4A9LCuEyy1gYSCDtNlDwQ6rEZblexdS1qPDInM7Fbi8ZiXmF8DQRDw
 V6QqvDgf+y7U8XVmmE9IhaUATgEPEx7LX2dDLe84RkGYiMfTAW3+FL9y5DqSvdwoi9Lw
 vg4XOl/j4tB2MDiPEdGZ/InKyziTUVXW6YB8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011875; x=1790616675;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rupxDw2uya4FdwitRYgTeS1CKciwORfp8GgH77Toe28=;
 b=hiapzB9CrEY1fo6VTBXhrhTGEImFTqTzwLsjuSznvbp3AXiUWnTJhpvLL3hnsn+U/d
 0k+cBDET1Tzqgyx97MFLzSWKazm7jI47WhutFyaL9r3Zcu7ZX4afLYm0QV/xJCexO0r2
 5QttgclAsWlE8oXYN1Vxx3+XlzQpe8Og/gWgqVSCXL88GnuMdC1AoUju9g5HRRXjTlSg
 uMbuF8KpOGJmrTvf7tusU+Vw4w6mYPAlquMH0PLZu0l8MbUjO9RA6N8i5BpHZHuIomTO
 EZxxXjsqmB/A+drtCvERcShB02v+FYmWwFjyNBvU0YdSk6EXVbhSol5Y/KVe7aGQGv/y
 Oeug==
X-Gm-Message-State: AFuF++n8sG1JSv2DqdAUZu3tcN8wBxnJwORJgmSoPwUxsnwQEex+EHNh
 S4Lr25koMmEheJdjSyoXRaqZ69Y7L9Q1TbFK9BVTMRUYuI5s+oY0wD9o8WSj6khLVmqM/yANcfa
 7VFaQcbN/JrUa
X-Gm-Gg: AYBFou1HuMdMrUk5biPDhYqsckS50bISownIIGmY81xlLnShK9iPhJcwQjl7OjrpWks
 uItYwHDhWwXl+g+ou4zFxLmc++3Sbk901vPZd7BrraLSHoUWwIOsRwcs2Azc56agzRuyPk19loc
 y7jD8qrO6uSjsXlbZ2NPI2hMEHXIApujUq/Aou8+ZnUUD36AsTk0W/8r8m2OoGaGFv5Ih9DyPMK
 VYltPxDBan8LqsCT9H9WqU14Y+mRtNOk4F/zaOK/2rmhxAIn5d5VTsXligXYsOxGE8Si9iXkbGU
 bnAAwVfZXpDTSiA9Jcw74CNKKlLiDimLnmqIHRdymZmT3mIKICXfhi6NfyK65xzT+aavLFuhvoX
 CM2Xfsw9YjLuwLZscXR39ZVzTqc0+yCuY8Pfk/JyyvbgPfNjxNeNU08ecOZHCD9TrngdWKniIRN
 XKjd5vMxUZRSkNBGug2aD4DrFe+wLo8iby3b3OzbI9Wbuh17P4JmBY9G3eeNkH0XfwTiLO6qA9k
 SszyI/YWs1PXxaWRznC+lw/YpeGoqfC6QfP6vDrizQ0Yj1O9vdjRoejnWwp+4LJHWlL29LVWTW6
 sj8ikXfYH6qln3CB5A==
X-Received: by 2002:a05:6820:4c0a:b0:6b6:5bf3:e201 with SMTP id
 006d021491bc7-6ca9b044cb5mr10522801eaf.30.1790009912143; 
 Mon, 21 Sep 2026 09:58:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4881f4d7861sm9261433fac.1.2026.09.21.09.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:58:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
In-Reply-To: <20260915200612.78621-1-rv@rasmusvillemoes.dk>
References: <20260915200612.78621-1-rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] fw_env: do not create lockfile with read access for others
Message-Id: <179000991159.3174152.13397758261898198480.b4-ty@konsulko.com>
Date: Mon, 21 Sep 2026 10:58:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 15 Sep 2026 22:06:12 +0200, Rasmus Villemoes wrote:

> Currently, the lockfile used by fw_printenv / fw_setenv is created
> with permissions 0666 minus umask, i.e. typically it ends up with 0644
> permissions.
> 
> But, since it is created in a world-readable directory [/run since
> aeb40f1166e ("tools: env: use /run to store lockfile")], that means
> that any unprivileged user can subsequently open that file for
> reading, place a flock(2), and never unlock it, which is effectively a
> DOS.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fw_env: do not create lockfile with read access for others
      commit: 4d96467dd86b4b75e9acc5c2ec02cdabb65e6411
-- 
Tom


