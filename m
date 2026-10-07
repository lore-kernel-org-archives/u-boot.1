Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F43CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 187EA8110C;
	Wed,  7 Oct 2026 19:07:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adm56gOf_2My; Wed,  7 Oct 2026 19:07:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E6D681106
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791400056;
	b=Rkk/Eefe3yNktE6utofNPMxe9BswrsXdJ+jcp4SMDC4FyaxLP0m24T53w8uoXJ5hLNzJ
	 d4XV+R9ak8eEYeYlK99urFDO7nvptuQp+9awgcKZtmo7okzdKlUstYDW3VYCzYGKCHdSR
	 mLYJB5OnYz2de0G9wOeKr96c61+10NaMJSTmyCvvxtZduzYBxSZW12EiY6BodiL9hORl2
	 T14P090tdIOHIhkp0zmGhbhzoC50lRGYw36mZpy9h/P9TfciJ5PpbJPXNcc0RtrZLdjPU
	 RCHUxk4R8CqusTeYpHHzE/QhGtXQTuKsSqUMmtplvpniScCrexLmTpK6fmrUN3Tywsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791400056;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=J5f9fQQHZ1yZQv1kqu5TcH7U0urW5pUYgJLWqCC83MM=;
	b=ZsszuqMPq5VxIyCCnyj6+/RohEGh4q/EdpPBdZwZwNyqk7/HwODXAJGQkvPtObaJpDP7
	 ApTGjDkJZN2nSb2t+5gMXM88nceBM8bYDFQhrLhXzoKPA30rcDlcnRiiZVw4hfvyVNjgh
	 9+15vG/FBDcWoYfzmbvrn/nztesJJULR6WsS9IvlAVXEbcS8fIhhcmdBWW3HJed1fheNU
	 S2tV9FJEf3loIYtRrog/ZOek5KulN4a+RBP2OEGh58wqWPlvuanxXW7GUK0JrHbURc0zM
	 dyQqyVAQ2QuYAROloieQ1oo3aJO/2NsU+cPD/T5EV+7Ps0zBvfUaCk7RPrVY5uHQF4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791400056;
	bh=J5f9fQQHZ1yZQv1kqu5TcH7U0urW5pUYgJLWqCC83MM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aOn736Jhcn7nT7ustabjsHQj0SABYa95AogRNkAIcJ1BgopFezxUYA5fFr24wDtdm
	 MZbl2cYYNLle48/iVrG0Rd13Bv/CuuKoFHhMfqXTh/7IYJePEUvOVAy53XZMdnsikv
	 V8ys7A+SMaYxAMGS5FpROKprN+7ZSF72alNljWsbgF/LaKXMvLqAGA232Jvfvgsd2q
	 D41sVwKqLQf/MaIiffKAqYSFK6YzRx++fyE4S1Glm1DSJM7ctx+i9obEug+5pcRz64
	 Ax+yEjpITMT+PONYv3jD2a6gOLExw7f1PmGQsfWOeTvtwdFUQw6+2CpH7G5kAnA0kL
	 4bE7Oney/Df5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E6D681106;
	Wed,  7 Oct 2026 19:07:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A216822B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93B616083C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoeHM12Lnzi3 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 18:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B097E60658
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791398524;
 b=VLZ+0AKjtHUqGlp7P/fD1Z491wOYRgW/XytFOA4CroGy5t+LelHa78Cy8xudjsp6BNiu
 MerLrCYP1yayuiFu6oJLvBg5fGnm2G+roYcUwi5MBuaLw1AIrrB2JY86vKlrdGv0SwU2X
 84SyxAeJDFz9fyaja7I75VQxKtF24iyHSIkuaVEIcH3UOUeAst2jlaA8n1NRcaSzpLWQg
 Tr4Wli1neopEE3EmVgq/5vAYELohpg/BsSVd+GYq3z7JqlJfUa5i77Y0mpplvERKsPO5n
 CcmCVJtgw6kRX61n0LGPBwDsSPfzEA7eWmHbOH20kkIs94Xv9wT4XKtGQoZx8Hue+eA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791398524;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=J5f9fQQHZ1yZQv1kqu5TcH7U0urW5pUYgJLWqCC83MM=;
 b=WPkZGYxaRrM96w3c/nsiOP3R2jxFtjtDEBuaukBzWJ/V49Yaq+7SjxRiZqfWzafvG+Ka
 TyOF/7Gj/pI97ZYY2HHWH/PsR61ksGfTKA/MiVoohmUVYtcc61RZBTUDfWpx6oqhjvZym
 aUbWQ0TqQFJzIoteUN5V/cIm8KHryMbezc4usrrfeQyFHGCR4Voc7QRnjFcje8R412+hN
 N9icM45VjANFVCtjlK0yaOF+BJzW2HTjbTjv2dYHR/Zt6I3ZPqNk5e2NX4q5utSMSHIdf
 tw9xj/iHElyWg6UHzMHHbb0j4CaCil2dQK24KyzQnz/4dBVwkKnAmxh5tupdGUQUNUA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AyCcDC4d; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AyCcDC4d
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B097E60658
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:42:04 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-825b40f8a26so1045378a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791398523; x=1792003323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5f9fQQHZ1yZQv1kqu5TcH7U0urW5pUYgJLWqCC83MM=;
 b=AyCcDC4dpJ2vskYlov2AMkU7Cazv8/5QtzNf/LRTO1SBiJkN0wAiW+uPIRiWs17HPG
 +vh97xhEtXhoW/ixBdsgX5pXirKKlHUTTcoZeaF+z008QSnizoeZeTjHBUWcEjTz5YeB
 76RuIpxeSRyxu6Ih4E4cPyF63WYSNxKtoehDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398523; x=1792003323;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J5f9fQQHZ1yZQv1kqu5TcH7U0urW5pUYgJLWqCC83MM=;
 b=iHHuI7bNxVjResf3UCloJnLD3Gbbtsqdr7/WGLfKWHNUhWagO3o0uLheH8zaC0PAIq
 c9idF8XH2r4shIQR6Ty8BweBbJikl66qX/gYn83ljLGV57WSlcUmX4wpez57LadVUGWl
 mgmtGJsuR5Bbe0K9m47eBY9QSPcQ3BNy52aXmKFUVBbnE5wrYfJWL6kRQjRuh07y7gGD
 z+AKn2BHQDLd/WVsMQL2+ncANH7cKIApZ15/M44R5wc2fh6BwJY33lZ8tgS2A7+WGddt
 322rLxx9hO1z/InVaeJMimp3rLb/IxnAWxvHkIEcAKF3GsLkLlrN7pfqHIBn5OgKXRCD
 BIcQ==
X-Gm-Message-State: AFuF++ndSK1i/C3Bt7PP56VR5NU5e7u0wXHI4OWg2NtHzE123KbP4dh0
 gNwnx2KfCwLR6o2covn07/UyCT3B1fVz2F19tQP2Ip+CXEu5WaWW1ZCQzzT9se0QBlypqtCgCh4
 oRig2A05+5phh
X-Gm-Gg: AYBFou1tk4TJBWeYkK8yyfOCMLnMUSaCBDmnDE7wxh9tcePwVfMEWrIMXKbEkISZwN6
 uUmvh1uU64HxdfVO7FWPenXrTzaO0stuaEI6zpsqhQmgh2phCwsLsIVV9ATL91b5eZQmIZIXP9T
 EVfsWoH8/H9dnaoua3NDsFerSu9oc34ofPdZUvSfyvydVmijawUForuXcxFfWemXTXvT1MTIaaY
 uzutSAt5UN9vewDo5OPzO71jo79U8ppjG7HDGkU016FNNWiIAUF1k2lKqqzvscaUGvc1LH6mkmr
 Kh8tgXF5fc87MoXzpQo61d1xkDdxn6THAi8t07SlOMOlWaylzKMQo2/hz0O1MFzn8TonWzN6a1E
 i3OoVNDBQswqO2PqnW1t8+vzMUIltV4qtrTqjLfst2bB+zVlnNVL19l69oHpi4ncaWYh/7Oxt9w
 2MQwNT0Ex6ZcjbOpOiXHK9N9afqLv6us7FClENLNSuYdkIBUJs9qUM5YDHidnMutqXsp4s8CUob
 23wr3e8lORTwPbGTAw5oS49bT1izXSmY0WktXHixjAaRUN+OPPuwkKR9flq+6gDPZFaQrTHEJJ3
 6/M505afLnVPnPIAiQ==
X-Received: by 2002:a05:6830:4c05:b0:7fa:5c68:d04d with SMTP id
 46e09a7af769-82ad01bf80emr4831039a34.23.1791398522956; 
 Wed, 07 Oct 2026 11:42:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82adcf0fcc5sm3570072a34.26.2026.10.07.11.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:42:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>
Cc: sjg@chromium.org, quentin.schulz@cherry.de
In-Reply-To: <20260924055459.125648-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/4] fit: use constants for property names in
 mkimage, boot and SPL
Message-Id: <179139852223.3398671.10675604746935692738.b4-ty@konsulko.com>
Date: Wed, 07 Oct 2026 12:42:02 -0600
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

On Thu, 24 Sep 2026 05:54:48 +0000, Aristo Chen wrote:

> include/image.h defines constants for the FIT property and node names,
> and most of the FIT code uses them, but mkimage, boot/ and the SPL FIT
> loader still spell a few of the names out as string literals. This
> series converts the remaining ones in those three areas: mkimage in
> patches 1 and 2, boot/ in patch 3 and SPL in patch 4.
> 
> Most of the changes swap a literal for the matching constant. Two need
> a word of explanation. fdt_property_file() in mkimage already takes the
> property name as an argument but ignores it and hardcodes "data", so
> patch 2 uses the argument; every caller passes FIT_DATA_PROP.
> FIT_COMPAT_PROP was added for the compatible property of configuration
> nodes by commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
> for conf's compatible prop"), which noted that the same property can
> appear in FPGA image nodes but did not convert those. Patches 3 and 4
> use FIT_COMPAT_PROP for the FPGA image node as well, in U-Boot proper
> and in SPL.
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] tools: mkimage: use FIT_ALGO_PROP for the signature algo property
      commit: 62ed983dad41c5515dfa0a222167a7a1d32955a4
[2/4] tools: mkimage: use the name argument in fdt_property_file()
      commit: 3ebc4ef7255f39c8a27e130f3a86c34bfda829bb
[3/4] boot: fit: use constants for FIT property names
      commit: fa2737df23f696b4919bf46dd01bb4b6191e3647
[4/4] spl: fit: use constants for FIT property names
      commit: ab0b18fc5697117b8bcd9b5afd740f34bbe031c2
-- 
Tom


