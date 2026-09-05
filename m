Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB52C79F82
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 00:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16BC24065E;
	Sat,  5 Sep 2026 00:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_MV4p-ThMCf; Sat,  5 Sep 2026 00:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 51B6D4051D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788567276;
	b=RK6qSL7Fs7utmGf/EnqeAzhFOL+kxD008LCd/yXeATDYn/buu6zIdTPD6mf3H6ERa2oK
	 YZwQiqaL806KpFJraXoyZOSs6QpPHX8P19yc1ZiEc0AJ0KsJvdaC7HmrQ5vAxSf338bBx
	 Q/X535pOR7uO0w0RP2Ckx4rcz/glSrMmYMxRXIikBFXiuh7bXzqyZYsGCc1dY5WpXptrD
	 BHPZwYR84sEygh1eA7msjefl8/DqQzo9k5qi6HvRgMq1cyn5uaEeJuHHWs9UISERjT5CJ
	 l34mnkp3z5ZusxhDStZlJ36VBwEyu9JUKXM6CQ5a7lo1ObZdRo6uaO97BbSDLeKN/Zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788567276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nq6fh74f+9wjjjk9ceKAVoQiKCxc5v8GaWLLfEP2gUc=;
	b=P8hhYAdOL1YkPlw1cQgh5o5di6Y1cUEnkXqL2zaVmpmIHGANwVS2vQWSgKBieiFbYTSt
	 XZaY6mjW4gQ1J7aFzOaYj5ePhQOnO7MLu1Sj4k/iVZRQpW8091lamfMNWREFHmjcOtGCO
	 qAJfOGWsevPIc3N4xM1yF/F49ujDDm7gabEMXSXm4R+ci2qMCKjHL1rxaGECv+9NV+ifV
	 mm8ili+wEi5G77FzMtd1vVxhQdLN2gBDox7v3vILhyjf38RSSVF5E9m0GCS6oBnYd7FyM
	 xAITlCQRB6vaQmEUXJAhVK7ITdInPypPGwewaC+LzvRWM7hSo69FE5Y+3PBqZCumY8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788567276;
	bh=nq6fh74f+9wjjjk9ceKAVoQiKCxc5v8GaWLLfEP2gUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8Bl/rQhBQVk9Scr0Q+BkKqrH8B1eXhsa+1E9HL+F96hjxiE5azdHw/r5zE0/wwm0
	 bf9lnzh2k/h5FKn96uAqUxgp9nU3M0vZBYvFpJ29JfjN90vCNTnLttZjffNifk3oGH
	 zKE27mo2lHxxtspzFQjtcwPmwhRvaWdDbei54sEpf/Nw3mmWtrHTWncJCZeJh2DWim
	 HfRKJDBTDQo11jCrwXX7Os5edznyswr5aQ+/JtEi+lTBG6MvQLHfsYv55DiPyWQKoD
	 jWShWTyJTbMud8si8QAoMOP/5Y+Gf2GKtQI3q6diZPMIPhXgg9QZuFQGLPxnZDNVqq
	 CBQx47mkuMtWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51B6D4051D;
	Sat,  5 Sep 2026 00:14:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 72AF32C7
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5932440519
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkMlL2UzbzPz for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 00:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 745024049A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788567274;
 b=kLKvnZcln9LLJRU5LUEklUpUEThmQ0qQ94ppTHm6KsqWA276dBWZJCIL/rU+iJJw2o34
 VvjuLB1xzHpCm/pS3e2e1UzlSMzu1Nni8YbKm8wT25pOWdpU8VG8/hI7RbwbUgYlgfZWL
 NH2ZusP++sPciKfs4aDjSPzg4rBwUBC71GcQVRObCXiMlWxTQZOu1kq9ND+TwBYXK66ZK
 HA8/8h7Ynqev+oXB2ANmK0QiPzoSPzloKzvYg3MuvB7hbuyhL7CF+Y0CB1sBJYeCSGECn
 hBJdew9zvmFHBKR5HkEdYkXDp4UuGAiVqtwMO5r3kYi0fVKNS5XPvliA4FrdJI7uKNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788567274;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=nq6fh74f+9wjjjk9ceKAVoQiKCxc5v8GaWLLfEP2gUc=;
 b=nvJ6EDPyfKxpdN2K4tK3FZK+GKacrAHIQEsLMHsLmGasq7gd3ttgGEP+0e9W+nvCWfwa
 3CpIxH6v1CGOA0IJmD7x3SkmfMIig44pX/ZYMyqlh6R2uw27zpU/qSvH1s2y9ovc6D52k
 RtjoEvBYLbld5HmzXWxtghp/2oIqnQkmqh1m/Mu3qdIdC6JU/BBkM/ss4R4Q05b6MeIrT
 jZBE/u9bsEUVpQlKIM36bD9o9GD0L5nBMQ+zlZnMgPsT8OszKxlvTuRUXgn2ev4Dqq3pK
 NonN6VN4eKWiAXvOCP2VQyqzG2xPVtbJavw9SJ41XdBcTLUX2WZ2yKK4ZyyozWZPYCw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fGpLIYtw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fGpLIYtw
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 745024049A
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 00:14:33 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4b381337e1fso1770490b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788567273; x=1789172073;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nq6fh74f+9wjjjk9ceKAVoQiKCxc5v8GaWLLfEP2gUc=;
 b=fGpLIYtwJ/VtTz1P40ADIVIEOyimbJC6LBa4ObQ2K7pdxvPb4Qb1/0i52Lp9hB32yE
 0xQrQw1puWm5dNDiYFB1phO3BTF+bVFPnV2B/i+MQb3F+3ahza9kmdQkZ3bKZg8H3LJF
 kqNiVa7hoH0WiM8TOA1Z7W/vwaLfIxEzlQzfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788567273; x=1789172073;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nq6fh74f+9wjjjk9ceKAVoQiKCxc5v8GaWLLfEP2gUc=;
 b=ahfvXAFO9VtgiZXkyT6m1e/9PhLUOsyklARNj4IxS5Bilc7NR1Ib+gXU68WwpWvvij
 yYCirVjY2FoHEy6GSecKrcERi2SxGQketqQ7Eb/YESySO7hKkEIydoVdz8+E8/AW4XhR
 2IlI36zdKhqZguFCybmJWEF3Ciw1yHZJ49qslYFYiFncXfH5JzG7a7n6M4ZVbkKXq6x+
 0F0/N5N153fdC0VdMv0mduonoNW+EbmthIJG1otqjuk6Q6yvv4GlHtkvxA1CPHdyaxSs
 lO4G2eLmDBFIAFdxH7Rdvmb4owtRHwhtXYfm1Iq2CQmybOwpojLdre1AqhE+HPmKtmTs
 oFGQ==
X-Gm-Message-State: AFuF++lttcImIR/E/i0B8pDLtG6Vdo6GOj4wDPEh/sexrdXTFt+exuaX
 wpLlk8RLDGh4xKphaesc9DahUQDK35hTDb55AYxFgDL5/AomcX/pvNT4FHP8EMkTErv+71OvFLg
 g5bn4TBCFZZ9l
X-Gm-Gg: AYBFou1E1MpNDemResV2OZTFfvz0nu1KoMjqfD6FcRdS8amPXDSOnToNBznGKYE1jia
 mkbd2jN6FNE9wJ9Y9ezaiCM16sSxHgBnqbybI1O33+0kTNTn5OE08LTnHycAiRk2AlLAkNqDnr9
 JyFx6IFCt7SzOoNd4N1JY7An2EgYh1lR4q0GTg4IYzqDTy+VdTAvgSE1Q3Ty+r5aCvuqsqrVYSU
 /VALwpAPdBaLw/1vW46m7LfuVgCO5dbfBMLyQxxv+bAh1Red1lRufkXNEM6uBxF++yIwRsBMMox
 NCgdTSsjXoBEAa69EgHKuiIXZABBOzrJ6c2stab1IIkXOdTVeuAqqppw+1FEKbrdrEOZJYgGprk
 PO7c6+RT1vZuoVSE70WIErtZJN/dqSWVdUm8VO3V1U3FVg5XSCjaqkVvbQQF1l02+91FfPEhWuS
 L5XypBpjW9vDl3cQ5pBBcggO3yz5Ytoyp+bmO2JKOYE5VchjwDGOghzEuPBlFijb7wUHJKdqqLp
 mFGhV6x3Toi026wy8OAiF/Zstevsn810uzc9ODZ8/14zFhCuX//5OhYWYdSsnEz0tKj1rEoSx1q
 bnAnPyyu
X-Received: by 2002:a05:6808:319b:b0:4b9:e65b:8c32 with SMTP id
 5614622812f47-4b9e65b9b19mr4403229b6e.32.1788567272974; 
 Fri, 04 Sep 2026 17:14:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971b97c72sm4027463b6e.15.2026.09.04.17.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 17:14:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <0b148859-b63e-4da4-8269-a3e23abb155d@monstr.eu>
References: <0b148859-b63e-4da4-8269-a3e23abb155d@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2026.10-rc3
Message-Id: <178856727176.3086907.6908898151199014085.b4-ty@konsulko.com>
Date: Fri, 04 Sep 2026 18:14:31 -0600
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

On Fri, 4 Sep 2026 19:26:17 +0200, Michal Simek wrote:

> please pull these fixes to your tree.
> 
> Thanks,
> Michal
> 
> The following changes since commit cc557af4553382f6f50e3ed62b9577054e7bc54f:
> 
>    configs: sc5xx: set default FDT file (2026-09-02 10:07:50 -0600)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


