Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD0606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vuzuWi7k;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eV0iqOLW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3FDE80E3E;
	Fri, 30 Oct 2026 21:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRn4ZR18ID2Q; Fri, 30 Oct 2026 21:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0375480FB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793395152;
	b=HKR/RPxPQJzN1fMUq004rVoTlaam/Tre3s4PPQhcAPEyKcgjT9bRYeQ8/ZMjtiMM0fl3
	 KgFzerV3uiQe21qHiDfjopoRTZGUXjun1+jAUlx5bNUO12O70iamu98fgCDFX6xZy8AQK
	 R7kY0nEEmG6Bltjh209jCNYn7zxCIxw+WVfSKLR9uzGf7qLNKTczB8C6oUHOMtqV05CIE
	 aNX3jDSC6cE6Iz/hNBrT2P3n8RrzlyEAoQYCh7pjlt+CxY+/f22DHARCRm99vLmpc07QO
	 tH014lirNK5M797ejMY5HdgVOmkntxP3DvRUWF5zA3swjfsiM4+CE2GNsxM+95Fzg5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=C21O0NXXOdzLQSZzfPM8kwffRTESJMSLbEayc3e1Aoo=;
	b=OPRUBs2TAbWgtTnt1zcQtn4ZmWzk628kLTbNEHHnjz8B1StlZ0vboH28C9N1HdgaXZIg
	 OmPLCGo4AhJjckORFGuzlH34/7jISTw/ezyOYt7Q3lbdmHAqdIYznFm8+zUFlVKVf8FqV
	 umVY1Y4akqC1sShTLlUEiaYt+W6w52Bmiyd5+JTRYF7xWZ+n+PQq7+5r0ws1iQjSbuVvP
	 De+cLHrxKWnASUXQCpJZ0HeqZuZP+6E0Hv+SN6fH7gCeSSGi2h2jwbuIoXOIs8CVwiQuD
	 KaRDJLL+xhJTpd5Y3VqSazyH7QD7+eRnaghlz7NT/JZcuVICbnT4gIkuaa/rsdGljMw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eV0iqOLW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395152;
	bh=C21O0NXXOdzLQSZzfPM8kwffRTESJMSLbEayc3e1Aoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuzuWi7k3DGpTsrnj6RJb2kdGA4xjSRFykuDA+F9aKrBWW85O/D3SFRwj1UAC3YyT
	 BPVaolTd/4kBsrQei4+CBJ5ao0dA9Z1SZbt7KQ/Pd2X/X7SF6zDDRE98IF6PIUUEXp
	 Mjp9+ku0JhY8iGKWG83tbEgeH8MB+snhuvFJkDY/a5X6jo9lTRmgLCHf+SeRtv0VAF
	 Mt4mfLe8NgWAiSEqns+AosNQpuULXBB5FrPKU8wzMQy7LljSyhp9twZ5Yxnd7bv8Oo
	 ojc9i/MRmDfu8vrpRD/+HqTbjY1KN1N5RPUMBexzKpAE97WI4e+eYVO48JOilIKa+n
	 17TFmGAIQzMzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0375480FB4;
	Fri, 30 Oct 2026 21:19:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20898529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03ECE81066
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w-GJYG79fllw for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 21:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0621380F66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793395145;
 b=dhWj3kcQsgGvIfuPXiFUhqHnvlSUJIoBGD19xNFq+AZAkDqV53Rqaui+MjsvMEYEmQw6
 xeBdnmMM13v6TQAx+xzw+Kw2PmL3OXrdOY5OS7oqxdaiKT9z9HeL41GIaqVKb9YBg6mSg
 zR5iIZlv7lkyvxaa2vKpqeEHqKdbLoNzyrOLyCEspTxET5wKhFiOrG9D9DtWj1Dy30MoF
 WFfWzxmOMAzElBhF7ozJ4YD0yLkEzfZR2wDudfajMTN3kif1v98jO4Exocm3GTpQSxiQ5
 rjrpD37QugkN8OlOJH1M4VYSVm7/+uUG7yN15j/6M/xh2SX1ouSW2ePjt2+KY1hwzsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793395145;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=C21O0NXXOdzLQSZzfPM8kwffRTESJMSLbEayc3e1Aoo=;
 b=NeMt+j1rvk2ZMMjEINCZMMe6ZHYU2v7foCP6bmPOcSAKoXcmi8nG8jw/Awg0kgR5RuvT
 WzsSwfqTbgPQAEhD8Qt4kLq8roB/XAus1NaSQOYRY66e+eytvhVy3HPmg6vt0sfKeNMxG
 LRn4CZWkfIvn371KzWrGgWKqX7CGBpTwhWuTI9CArwZ/H4NSusibNRyLNqS5OgB6z2I1K
 KCrFrF5wT7cpGShn2j8EnkVzkDBdxCn2M/YaeSFLp9f+sxbKWC0TBo6cyvJO7kb32yS5i
 7iL8xvZpS9TXjzdQSsohQH8nMSJrWFEaDP1iojrqyGk7m+u82Ae8BZGxRkK6kRAgzzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eV0iqOLW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=eV0iqOLW
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0621380F66
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:04 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-705cb6ceebaso766818eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793395143; x=1793999943;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C21O0NXXOdzLQSZzfPM8kwffRTESJMSLbEayc3e1Aoo=;
 b=eV0iqOLWJptqRosuaWlYE91WBSKeD1w7qo/PEqUUKd663Zwy7zzxajjRJbRxchTpr3
 rHYDKZA2u0wSKf5LxLuloL2XDWsLji91oFEcaLVgv+EC53fgt+KMi0SKF1KlMxsnoVMO
 o+xFJZfWjfv1TYf44sD/kmr7X5zqRTId1E1e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395143; x=1793999943;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C21O0NXXOdzLQSZzfPM8kwffRTESJMSLbEayc3e1Aoo=;
 b=zRZCy3fyYwBLrJuYWmQwFvOBsLqGhpGcrQwdbXIvo3CH7/N3Y1Da7ir9SWUIEsHNm6
 Avzo1X+nYeoY4N65bMQrTyEre3oMkfyBehnaw7FwfVmyenyr05kLEbZWOFoos+BJ7q+S
 Z26JRFstJPEHsasr4WXH1oyx0HIBTJ/vaHM7bbOSDv+cyVAlrkOJu6IqmS+CF1elndnv
 d5Q9Jr5a0yG5PfoghYy/MEBpp8/g6AOOcO+Dihn1gClLrChrQ9FIz5JtXIdHw95AE88G
 eUjiJHbXPOCw2Zw65n1gHm4XmTDTe2nYMc3RAGneS2SeoVHRklNNHCjmD9aUR4PplEuU
 QEiQ==
X-Gm-Message-State: AFq9FYK6aqRs+cAgTa+AzFsPjcylWF6BUnAzVTVJA+6G+28mwzx5K+pw
 R+E9FCS/a1xAPEp7e6JehNiZYXMeYoWPh0mImoyOTH1YK/IOCmKbksgvV2ogr3qcF24=
X-Gm-Gg: AYBFou3QxDZ4D9O1jAuL1rV7I9UZ1hti9vFrb50KKhWDYfbmoAEfl1Zqu3dKr+IQZep
 ZCjOJptPF8E0CRN/mMbs6ZglzEkt9eWEZlRZYkTu8FxVjhoA3V4diKbuv9Cz8E9WJs+iTwzj5hD
 aI3n1wv0BxrC/qnHDL/HThf3pGGcQS+sp4RMuYBzXMGSAoqt/kkVs2lu0WsnSXnkAl4nCoekWi2
 fFsi0gLvtohjdvy6ADAfr5aTyWomVTbEghXlfpAwcmanb/bbcSTtXuZelk+9stXo1KhbyaJB+kH
 DZpzt+SPFFEMdaS3Z0cTQQIAHJ9zszec1SddO0a37pdBeMRFKit1aH9PPXcBEyQnd3FEzVAp51a
 tjBB26XdP6jq4CbU5TRChPt0tacTpFhMlEVI3dFVG+ZyyjNVC+GQeFr3G7Wp0yh+tNNZ6Hv+8eH
 FRri4pX+IKkN8f/hsBfpWWk6QyW6fxEwN19srn8C/KZV6q5Pq0vdsYlaQlmEX47410OEW5HbvHz
 vcOx627NsP4fVO+v28Bf+pUaXvfP5GPJ6yVxrarnArx67HH/0E5l2mVSySKcAUZsoSlhDJvziM7
 Tt2szGwjCQinjN9KbfrUKdQO2dj2xQ0xPAR75iwNc1q23pTADTWkL1X9W7mvNn02RJGSlFvag47
 +Aasr36eUrH91gGgtAwSVS68jGq9f6adiwtxrmYSnhd4XDOGt6bEvrnATX23yb53JhNRhMWOG4S
 y4HaOgdEkCoWiNzb8Kk+YZC86b3Fj8Ug==
X-Received: by 2002:a05:6820:2009:b0:6f4:e301:cc32 with SMTP id
 006d021491bc7-714f279d149mr2047282eaf.78.1793395143497; 
 Fri, 30 Oct 2026 14:19:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f660csm2829799a34.22.2026.10.30.14.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, 
 =?utf-8?q?H=C3=A9ctor_Or=C3=B3n_Mart=C3=ADnez?= <zumbi@debian.org>, 
 Mattia Maldini <mattia512maldini@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>, 
 Vagrant Cascadian <vagrant@debian.org>
In-Reply-To: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
References: <20261017173458.226395-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if
 supported
Message-Id: <179339514270.3804820.2967894063501823320.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 15:19:02 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 17 Oct 2026 19:34:28 +0200, Marek Vasut wrote:

> Since DTC 7c78c8542d73 ("Added empty node name check") , U-Boot binman
> use of placeholder node names such as @fdt-SEQ and @config-SEQ triggers
> DTC ERROR (node_name_not_empty). Inhibit the error, as these placeholder
> nodes are updated by binman and replaced by proper nodes, the encoding
> in DTB is temporary. Since -Eno-node_name_not_empty is only available in
> DTC 1.8.0 and newer, introduce "dtc-option" make function which is very
> similar to "cc-option" and other such Kbuild functions, and add the DTC
> option conditionally.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] kbuild: Pass -Eno-node_name_not_empty to DTC if supported
      commit: 6c4daab646ef46c015f31ed56071fc5e3e7324a3
[2/2] kbuild: Do not pass -Wno-graph_child_address to DTC
      commit: ce38023f5d06527541ab6e99ec6fdbc89534ac7b
-- 
Tom


