Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72B7C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A488040AD8;
	Thu, 10 Sep 2026 14:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRMBdr3PGFL4; Thu, 10 Sep 2026 14:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E989240AD3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052313;
	b=UiLi474gjNrgl2iGx+kyXvV2GX09h2vo2lBAhkGsQXNzQVPKb8XfXDaOg5OUQGliJwcd
	 FXwJb8DXGeFjEudICVAoWNU9rvJWayRHdJd+drEUUXGNpF5ukZSMY5cK9GT6LlF22e7Po
	 KvQAQCQ6McKuAieP/cjo/OlA+ujg0K2cSBOnwS/nd+Ce7FNrwPjtdQvFNokWknFSM2X2Z
	 KlACbCK9igqws4w2vwK92o+rPMCv+Csp1PshZWqKGhccGw6qoxBW7y+vx4j+aaA7fHUrS
	 ixpwGT+BDF0NXI/3J2LecpjDpyzPwBTOFXkljClBG32Jtans2qMrG2uGctIKuoM4DXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789052313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9eM0nbv8pfBKT/rXrX3ExL2l0+5cTLK5VNUvRu9fZsg=;
	b=RM1nhsHu5aT1QnEXzg80PyByvH0SUZluUkWCCdmDPBQACVxAcQCqNOiQqN1oH00TdCqa
	 7NFFRt2baC1p9Tpdgs4f7kjjMpDxXA954aVzCYk2t+QJ+2bbuSdlgBtrm3LN6VXMMJjIw
	 I5nu7jQYRyw8IzD3pMkP9nd6KBYV6L2AWdYm/gEhfBBo3avZEBjtnCKEBzKO/ZsgDYPLi
	 cNdHisK5VFWfxqqcEWdcjD4We4z/Y+LkbepP+mSuYKWwSaiCMpHtOTHFQcKkJC01/bgVs
	 oAEVSFr5wUOJcGVnyzxQAofukzossFrIC/kd/QASuJnrCQRp97dsGQQal9vg5au4J0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789052313;
	bh=9eM0nbv8pfBKT/rXrX3ExL2l0+5cTLK5VNUvRu9fZsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pVov76xapgecB5nIhsk8aDa5uNRFgU96L9/gHM7fk0xH18bni3Gnfx0L2j8wWgqz1
	 ZQDgjGacTEH825gpLfQpG6hyxmuNVpIAVZl71IlUbXgpEhX6fqEZ9BGbv9NDFleIs6
	 BulDaBEhkFCPlFE0PbFK0hFVGif894u0zBlKAcThjXrXturzhMNPYqTXItqptpsrd9
	 fk5OsCDo2fNWekBnZOzkiuJkuGwS3/CmAGUXXf9+4GWQaOneXyFAWZ8hcHWYcZ2Zbx
	 AJjTB6o91USL2qpPtrB85JZdZRvV4oI3Ao6wvBOQmlUuaC1ogAOHHCeaPROkW9cIcn
	 NDFsuQQ69LAYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E989240AD3;
	Thu, 10 Sep 2026 14:58:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E46BE43F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D613660B50
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRz3_8wREmwT for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:58:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EBB3D60B4E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789052311;
 b=E1kVxIoG4jGSD64aWBTcUCx3310X4pQ348KQDJIn3KuctdcFylphO72Bs58cIOufNdUo
 FbsCyUWTcEY7pcUfEsBKugVMNnvu61t1li/eIlUNUN8sGiteTG8lxsQ8RFuDN41N76u0r
 0rm3hsGPJ3tJE7+dOTx4ioztqLwY+1TvpVifxv0pFN4FxEGfPEqiqaPOYorFXq4ycBR07
 SwFKDCK1vu8Aa1TBGBfQw6uoapatZ3CyBK6rUxyonAYEA/GimH8L95wBp/ZkH7pYSvpxG
 vyyDmJtE9dTEMU/D6LMS0mheNJTr7iy84tz4UXNljbb3ncHes6xq1JqTD0o+NhyCz+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=9eM0nbv8pfBKT/rXrX3ExL2l0+5cTLK5VNUvRu9fZsg=;
 b=jo3yOSXvpBzOnYLbfGpFUwWqYIkwLPOgBYdhzqajOF/1yLt2Bx8HyNZkZSE+exdpMPNZ
 OcbmnXD8NXI/U1+OcapKVSmygK50W0Cgn8O21oNtBC0MgLx4sor3/LJ8kv/5KJ8BG4DMH
 bsmIi8n+C7E7jj7ycJhVucipTF7zQc6a4IKUlAvbsGbZ9BkU04GTEVSzktYOiC2Xdhs1i
 qIju2v8xYeLs0MNQ3NUaBFxvSl+cEc+lyeSyfOzGFap4cUbc1EDEhq1L2djAZfKnyEV3T
 sYBTllNIUSLFoEYff8NXv98XAwYRTaRUiGiO5+ha+IM+cd2hjEyVbiMtB9sLVYTlKPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PBSAR7SL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PBSAR7SL
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBB3D60B4E
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:30 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso4777986f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052308; x=1789657108;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9eM0nbv8pfBKT/rXrX3ExL2l0+5cTLK5VNUvRu9fZsg=;
 b=PBSAR7SL8t1B2tLLhYM19k3aaa+48p8RT8Q9S1VbCWB7sBtujoGXbTbqQcnzr6WQO4
 PC5N1bMyhSOI2jAIdHOwfdooUKWi/10m5ktZKN6g/AfWAiD2cVH+7eakKsRKFoZxiRL4
 Ox90geX5sh0zuyaD6tV9L8TLuVgSZZhtQV0dwv5ytrJg8cZcbDe5CrZkv2884Y0uKg2Z
 HEIfMy4PrRuL1zxzqz3m0GopkKVqO75I36TuruXklFDb/NDCRJPJ3rEvqhMpw3qDlxEu
 feoJckeHIkjSrsMwd2o5X6cDkLqIn7A3gOeM/JzC7Y8jYjL7G10MFMk/0g9PC5teN8jJ
 nXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052308; x=1789657108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9eM0nbv8pfBKT/rXrX3ExL2l0+5cTLK5VNUvRu9fZsg=;
 b=GRRIZWw+LV+lSt9S3rGWU3vlZXOEHdklhyTWBGP/f2BhyjjrwkMYTkVEas16SnV0NJ
 qA/US2o/4lZ1/R4Ho8pM5p1ygM4+W1kEjizmRXopz2qwGEuNBTcUcq+0XHGrYYjHcoXU
 i2Mhi52LNtBe0ZMnFfD50WjkN2LxPRZyfpHjtHnWCLo3NQbL7J5IXITWPGJ7+IPc5J/K
 SfAJv2rk1uX6EcQDrbByeVlA2eg2cK6oTS/iFN8JSL1TDFngWBze9C/fnBZXA8dh9HR1
 g0nh9/JuQXQf8cLZmsOUNPgIBFA15D2WT1oLlTqQ8HkD77R/zdeN5d8ZeBMiSqs2I0IW
 MVDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzy7Zi8dmxJPnhx8cFPONjH0t+nr77e2IDgHW92DN/RwaLzhoxK2akUHX2WAEOsmkIFBcfRymM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nQvrCxX0waPQ8dH8WARjbIj3BMoSic0xCsE6s638uvZwyyjwJt
 e+lxKfjeZTRsGOBZmJmUD9lYlxc8fwHTBGoBsrhCMjYjmN7K1B02So5X
X-Gm-Gg: AYBFou1aTx5KUIh2ByAZerG7PsWkMOUFW1pZhAPgNvNvhC+YQeYMa1e71hEI7OHC+ph
 2hc0sX1Qjwz72fKru+4pXzM+SRwhBJObE7W8LsVYo1SeviAMLShSJ26Yob6WBBMIifkHOdInhtl
 4XMA8EWZW2rkDIP4k1iUaCRVZx4a4tuZ9nt6W3owpKAWdPPtv4N+hek/im/qNGv7BMg1bqXWS2r
 iG101Rh6aXusBP3WJSe39lggF4uOdSJRFf6VIXZ7hhGrCftthjAPLHCU3pkIzTxacODSPQh/RlJ
 QYUuNvwSfHGUyuXDc7P+r7p6XaToB7xOzgr/2cA1ZfQCHBQu8g/m0sLzsqUlKuun7PXCGW30YJm
 0f8CxLwbTiIeSWeyw51Y3RXXM4rz7/51XCcoRgspoViQNAUZtGrO8El4Kimk3CWnPyVi4agm/s0
 iyIivD2Tb8dCJ6Aels9lL4LtglHBAC4pyP71ubgbKIAHr+YWOjaZiikHHyv7v/E7+k8qO096FF5
 6YSWk4lIlD73upw
X-Received: by 2002:a05:6000:200a:b0:485:9139:2733 with SMTP id
 ffacd0b85a97d-48591392ba2mr34534484f8f.6.1789052308108; 
 Thu, 10 Sep 2026 07:58:28 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859207c28fsm47072744f8f.5.2026.09.10.07.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:58:27 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 0/4] dm: gpio: read GPIOs in of_to_plat(),
 request them in probe()
Date: Thu, 10 Sep 2026 16:58:26 +0200
Message-ID: <20260910145826.1275945-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFLszTi0TpqNDeh5FuB9966FRRLqChr3ffhvS7cCzKfaSufLPA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 2026-09-10 Simon Glass wrote:
> I wonder how many other drivers probe in of_to_plat() ? It would be
> interested to get the scale of the problem, if you can.

I grepped next for gpio_request_by_name(), gpio_request_list_by_name()
and dm_gpio_request() called from an of_to_plat() method: 50 driver
files do it. By subsystem: video 22 (panels and backlights), net 6,
mmc 5, spi 4, usb 3 (ehci-vf among them, which is where I started),
pci 2, i2c 2, power 2 (the regulators in this series), w1, tpm, sound
and misc one each.

Most of them claim reset or enable lines that they then drive from
probe(), so they would convert the same way the regulators do here:
parse in of_to_plat(), request in probe(). I can only test two of
them: fec_mxc and fsl_esdhc_imx run on the Colibri VF50 I have, and I
will convert those in a follow-up series once the helper is settled.
I would rather not touch the other drivers,
the panels in particular, without hardware to check that moving the
claim out of of_to_plat() does not change what they power up and
when. I can post the list so their owners can pick them up.

I will answer the per-patch comments in their threads and send v2 once
those are settled.

Regards,
Mehmet
