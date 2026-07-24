Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D05DC531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E929A40AC1;
	Fri, 24 Jul 2026 09:40:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDPlMvcfsFLr; Fri, 24 Jul 2026 09:40:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5439840A0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784886046;
	bh=fDgV70t+tyKX4+z21jZ9OgRRXnhcuq/zYP+XoBP7djg=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ekcMzCfT2j17ztdhxNt8lDzZTw8lUtt5kA/c3xY9MTrKoqH15Lw7qfWkQD9IgMEo2
	 XOdaOC5FVeTWHeuH4lEBoS+4cvAKuYjbTnncuRWv9j3bfKPXpziWIZNX98lhpeGQ0h
	 rRNADrAxViIN7YJnuYtzobHot9htBoy4/TuxXdRhpukCo7Eu4z9KGA6OsWDT++Bg9k
	 9p+niPfMvlNW9FZE0fZU2l3VlJHCuHQ/sSWu7b3AazM4SW83pJ/k2tNZv298bo+YCU
	 /txCCRNtAUDu4n7ES2sZDG0sVOUZAGX7AIWcEmlRD/CT3FlAXi6MmmMKRJojjkZl6Q
	 ipXLROkHTOVog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5439840A0D;
	Fri, 24 Jul 2026 09:40:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEE5A347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E126080F0D
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEAsefpKhDnb for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:40:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 33BCF80EBB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33BCF80EBB
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33BCF80EBB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:40:43 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so2816585ad.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 02:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886043; x=1785490843;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fDgV70t+tyKX4+z21jZ9OgRRXnhcuq/zYP+XoBP7djg=;
 b=O3x08hnHaVGjlWKBqUOLHCHJLorS102kXEmNWqWYBQ3ccp8HEZBn+rWWbZhR8+5bvx
 noNd2rQzyZ17r1hnsoNS87U1Y9YYQgCKpeFGCGtLgb1e9sv+YY2NKGcrorwvEJfQGY/z
 Nt6/ih3F9D0Or3oL2PJHlHu/xJEwBewBYrWFKV9LIqrLfSYItny+hdaqnBuM73Fq8qof
 AKZPBOJI8RzG9UTrrg0q8WtaF8BrHVR8NNPo0TW6rROIHiBHFb/voBBHme34fWyZykXM
 dkw7zlYKJY88H5NpkKDz3r+/SnGD5iComFX+KfAMGuysdz3V5qMSyG7tlE6S4xgmGiA+
 TOnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RphMRf6wxZdOgqUsBS/iVVsiZvC99RXGlcoaD8jJLS6Fl7pKc5lt2UDVDLCZ/mCBq7UQ/2cHTY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxYKWxH1EH7Frr21oExTt9G3OXbbFl9vzG13/Z+flboroOyZNfx
 z5tlZ4kweJMa+RFleNfXfvdyhGmVizn2ZLMP5Z77uIr2ABeaMS9+AhAIhB8Q/T+z7Ik=
X-Gm-Gg: AR+sD10jGNwAUKdqjCmYFZV0jHzi9AhHgtMtplZPKGuCuwEa/snTc3xbIP3+F/8CzUL
 vlD6rqFsrAOZAXXKzStpkUsPgwGlNcQz3Mxz3WySjwzG8y/ekReHBK+TVy9LP01pJNDNg2T8l4V
 aXKmNwT7m4E08+1QxHTg3ytuXww4vTb0iuX9s/6pe8ztJE8BXfI1H3X+sqniiFeHQQwU8CfUXcL
 aksa74qammMvPuKTiT01IwsH3hTDJI1svJVHpRyVD7kdlwWthUDdCEtbXMUeDgVwlwRYNrIF0WP
 UhBuaJ1BJTFclJeHx8C+tw+BSbHLITiC6bg3OWhd1d3+d53O/QhJrSt47fF2GaDx8VSygFQbxLE
 2tOAVnS6t91xqAl0IDVR4vCXPRxg3xMuhiDp/o7cKBxQUjy0v2aPDpkBVRFMAyUdM53+QjkVQBq
 4wTUWuyownxDCrQU4fge0=
X-Received: by 2002:a17:902:eccb:b0:2c9:c46b:1286 with SMTP id
 d9443c01a7336-2cfa74ada2dmr77670435ad.34.1784886043377; 
 Fri, 24 Jul 2026 02:40:43 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f2e6203sm50502905ad.44.2026.07.24.02.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:40:42 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:40:38 +0800
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Yao Zi <me@ziyao.cc>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] riscv: Skip riscv_cpu_setup() when CPU driver is
 disabled
Message-ID: <amMzFk2qRYLxc_mw@lliang-1876.localdomain>
References: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784886043; x=1785490843;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fDgV70t+tyKX4+z21jZ9OgRRXnhcuq/zYP+XoBP7djg=;
 b=GHLjURHfKwYiFTj1fp+0Eg9QZwgrc+fHl7g1Sd4LhxTiT0VadxpaI88peoUGYiah22
 EZ4IK3Ub/vHZnJJicZ596EnDlq903iXKDMnfIO97jiLvQ1PSeUkLkdNycTYm3KVf6coD
 CuZ/KKnGU0+RO2OjY/X0c3xCl6mdYzRboRZUx0WT411nwPssPAn0sNpJIcyUzIURhvZQ
 UDPEoLMCBPU/rh4roEP1pSIM7LFSX9AJjG0zY5XbTe7Q5NFLosUFWUcmC88Y+CDBKwLz
 70KhzvDRH2miuhuyLROgJ2eSSV00WxZEi7MBnEy9FBB7PKqV5wGtqIZrKks6nnA7g+Q7
 Tygg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=GHLjURHf
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, May 11, 2026 at 10:31:52AM +0200, Michal Simek wrote:
> Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
> instead of plain ifdef"), add an early return in riscv_cpu_setup() when
> CONFIG_CPU is not enabled. This allows platforms to save code space in
> SPL by disabling CONFIG_SPL_CPU.
> 
> Without this patch, building U-Boot with CONFIG_CPU=n and CONFIG_EVENT=y
> is broken: riscv_cpu_setup() is registered as an EVT_DM_POST_INIT_F event
> spy, and when the CPU uclass is unavailable uclass_find_first_device()
> returns no device, so the function returns -ENODEV. That in turn makes
> event_notify_null() in dm_init_and_scan() fail and triggers a boot hang
> ("initcall initf_dm() failed"). Returning 0 early avoids that failure.
> 
> The compiler's dead-code elimination combined with --gc-sections
> removes the unreachable code and all associated static data,
> achieving significant size reduction without preprocessor guards:
> 
>   spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
>   spl/u-boot-spl:text -1460
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>

Applied to u-boot-riscv/main, thanks.

Best regards,
Leo
