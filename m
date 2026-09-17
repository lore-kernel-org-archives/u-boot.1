Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03581C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A755B60603;
	Thu, 17 Sep 2026 13:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9bxafVVv0_p; Thu, 17 Sep 2026 13:41:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E15A460613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652472;
	b=DZshcDE2kkHinYGmfrkDhkLk8dxxbzwrIyq2jLv+QgtpUuQEX6X6NqTYMRCE9aWV0nqZ
	 h6xI2Bn46yC0SqKb42E3peja8w/v0a2a+zwZqvPi2DNQZZx6/3/NRIG4pMkdCgA447p2V
	 ImUeD1CR4SBXBzUwr1SYssNn0Yn5SovObkXr44mw1+SMUIDkkj0vLEmlo6/MK47SRvUPs
	 pOSpNt7Lop8ur6gEKmt2kDzjFs5KneqHLNRGDnO9DC3qCkHp+oFXOfTrq3GemN9lHR/og
	 HWqtNsBPYAG2NaUqZilwi1/j7tN01/49AlzeuvHRvWA57IgYlwk7DMnznWhOzuZF2DQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UeybssOuGQ9aunsAg+nb7i6sUPLJPAT2hVooXN2Oyl4=;
	b=fRuX7h4p9CGMUeMdnAn1ydYSLD8QVz4l2cTyn3NFlTTVt7Riqh5Ip3yiae/I6k3o5DrE
	 p5VfbZ/O3gYnC2Ld1jDw6uG1NdLaVa8q3xZo9KZ20dKmLdQ+vRkmpsSkOCZAWDJFYXOOC
	 e2HD0P8YbaLy92QALjL3sr4HCTpjfPFDRy2JP85CgSo8tKyF2WPnaM+MfKdXzkpYkll1q
	 fTRR4GbgGlhOmphR+VIGawVZRL1wu94pvc21c0rfH/criE7revKB4ytszM2wloFqLICuy
	 bAfLxp8fhAS800+RB4JuGNt1Mmb8bsxyjR7qpRqtmz/83GTsNs+IS5ky+eCmL6I6qAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652472;
	bh=UeybssOuGQ9aunsAg+nb7i6sUPLJPAT2hVooXN2Oyl4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=biCSEp72Ro33MGQbfjMQthACIyXwINgkl6zg5jC2EVFFKEelI5cm54xbflhXKGicJ
	 dAPf97LDWBPdDW39q4YqXxbU/6Enw3g4dY0kCQ/Z3Av1wZCvUWpTO6JQc9HGxpVeCr
	 pjr4fpsFIoYYOXixCLwG0Z9ZYW0+MXB0EsWP3TL123ubOhXBgdt02DzsyKwS6X2gH2
	 ADJP3ygqkvHLGHAFmlDQk7pJAcFZP4pQgVDNvDd3q86U5RFssQusP55Sf3uLLiuX9c
	 i1IZbuXl2DPJsbDOi/p3U0ZkFQPo0gidLsH1ET3XZYahIvgugDpu6Q/4kQBl575uqV
	 9uotJrIt8LFaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E15A460613;
	Thu, 17 Sep 2026 13:41:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 82B0042D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69077400AD
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ludnFyq7QRh2 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B603C4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628218;
 b=kgzbi1vpWdYPXNNVyXlSrV19SHI1CgwpXXHKZVcwlWMP2GANtk+W69Vbdt7K4deYm+r2
 qmcyHcHOLqVrvjmQZDY4kDpkwWjNLpCdpF9rnVR5deoEeapsLQA4Gv893TIpNcU62IK84
 tNlh/YwP7JHTh0eAT/xyvZoKXqzm43GkIw1QjlHYZjNWDF1RLusi8N2lKrYvzwUni39TM
 0l6qWxEy7rfeGUvbI/hXO11bUmmEgsW8Yh3baJ3TUKQeYhgsMbeup8UYWDDmX+yaLJoG3
 9qw4xMrCw0DNI5ZaBHcPjt1I2NSkutEJQ1yBUnbQ66NriKjT32/PuZxGL7AVyJGzoig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628218;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=UeybssOuGQ9aunsAg+nb7i6sUPLJPAT2hVooXN2Oyl4=;
 b=jvQaCyy+smqrJK/6st6wavhEUW8lzJTqqts695arp/48Fg3Uox18hh/ZFlDLosoMgZOu
 C8EqXvRrGa3znYTVmmevSE2S+KQimymCoE+bJrlPgrQa2X4pTg4L3IeHK9WutBuID//xd
 NStp9T44bkt+hfMg6gE186ERxHlIi++z9uwwCa9TSOccO1X+lPMyWZYGZiT2XmoV/oTD/
 nHKDFq6ACKoLgoSauhvPsZQk4y8uEm+jQ5KjD5tqxXm9h36XjtsrtaR8QeYBIMbuF5rWj
 9rzQ7ZfN80jTj7QnfgKeqKlD365w35II3Fu5mn+GEpFXXUnOSqvdPZdC/Dl5lICMVCQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=sigma-star.at; 
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=iJ7K91vr; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=iJ7K91vr
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B603C4005F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:56 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso965595e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1789628215; x=1790233015;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UeybssOuGQ9aunsAg+nb7i6sUPLJPAT2hVooXN2Oyl4=;
 b=iJ7K91vrOzfi/uvJmNZ/sdygcjUkpSzLZPEvPKWviLy2aW8FxWSneqITT0cODO1WGL
 kSWvVTtwaS7zfTeyn8w3QaayAJNDq2DoyhZiAdab9A4rLRo0AC1JEkJXE+i+g1BgN7gp
 ZbUNaaCFtUX/8jqS87SJvyTvYGgv8LEYZbre5/du2ugE16RqEl1/JXxkWVwdla9S6EVT
 JvVCXbebpv03fftBLBcYhems6rmEFD8wXyxlXJWdm20PBxYXvQx/GLGephs40kyU31Qt
 1Kl57FTIosvjHOdyNYnrKeEpLYc5Ipao+q0pymPvgt4gImwTvAncKfi7WakUVu4B4/Hs
 mItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628215; x=1790233015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UeybssOuGQ9aunsAg+nb7i6sUPLJPAT2hVooXN2Oyl4=;
 b=gFAoYNwL1RArW/3/e8PCDufSCZ0yQ54o7HNAPmE66qWxoImw8HVC8Kt7R1XZBa9pki
 siVeVZH6fFPRjpInpMUe+eFEMR9tpafknVSd6vlVHYNStz6qQL0JJxs/o++4Ui1YOVI9
 PkrvaJPVYkAn1K7H+y8gaep/osy3xCgLmirSBrsTKq7dr6rpAxQnn1TGuoIrQpOf/bQK
 zvTrcO0BcrUU4ifBnfY9E0mB4GPkXDYXSFsg3xIVWwd6NGEmM6waRG3KmaNIeeKM+zJ5
 HNeu4eOBAWVcbtmIzjKuaF8R7U2zHmcTf0KOUJH8xC1rBslgkO7GvmZ2olBBrfuHP7si
 2IBQ==
X-Gm-Message-State: AFuF++m4YQBr10eMu3khoUV/MuBtg1cdIupL2L8UkavTRWHMJEsM4XR6
 zw+nWkvPSkZ7CDTH87qUG6n2tSJvtjr3N7Qun5p9tX8RYYoUJqJ4QBwmIMIxS9QLm1O+pBjMRbG
 f0McLbn5OJw==
X-Gm-Gg: AYBFou1pq0YmyAWaL6XCULRU7Cw0dHkPm4olycY7RtnzPCRCn3wMqbcO0QeeAfZsZvt
 JCqNV0nxVonLIdae7659JvLcCH3tKa8RPRj48pJlf6XonNP9VZUzUv4STmok/Ro1FASkPkYBcek
 8+OvD92Hkd1w2GQqr0sR4E6Xwd8w0ZX8KNcQ1mStPduqy4m6zSGO01flBdUIQLOmDKQlF3p3sOH
 uv+C9v2WMZvbEvDAeDL+5zfh/HN6aoKti8Rht/CYi54DbMUclpZ9hoaxHG3spr+17guT9RWJgrX
 wLH1VuTePjc9IPTrZTSmgu2u0xc+TNSQs7QU9VKRGFkArVorX7TrgMiNAKlMTbcUGFpwVHTZXoM
 WM+BFwFY22L9AR5CxhpQZFcz6GpvS70ylPaXGsfxIp8Kx/5yXgORJ/+02XzptXG/wGuQPwg9sAo
 hwoY86wiJN2DTxLSUsA+qJNB+6qx4nMVStI5OP6lVmUX5JyDEtTGvtUmyZDKj+b2CdaUJQQahV0
 ba9dayzyvM=
X-Received: by 2002:a05:600c:e549:10b0:49e:6865:904e with SMTP id
 5b1f17b1804b1-49fbd1ddf51mr17565575e9.12.1789628214626; 
 Wed, 16 Sep 2026 23:56:54 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd256105sm47522705e9.14.2026.09.16.23.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:56:54 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH 0/3] binman: pre-load: Allow signing with an OpenSSL engine
Date: Thu, 17 Sep 2026 08:55:42 +0200
Message-ID: <20260917065545.1989088-1-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 13:41:10 +0000
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

The pre-load entry type signs with Cryptodome, which has no PKCS#11
support, so the private key must be a file. Keys held in an HSM or on a
smart card cannot be used.

Add an optional 'engine' property. When set, binman signs by running
openssl with that engine and takes 'key-name' as the engine-specific key
identifier.

Tested with SoftHSM via the new tests (both paddings) and with an RSA-2048
key on a YubiKey PIV slot. The tests are skipped when softhsm2-util or the
pkcs11 engine is unavailable.

Lorenz Kofler (3):
  binman: pre-load: Move signing into its own function
  binman: pre-load: Allow signing with an OpenSSL engine
  binman: pre-load: Test signing with an OpenSSL engine

 tools/binman/btool/openssl.py                 |  28 ++++
 tools/binman/etype/pre_load.py                | 130 ++++++++++++++----
 tools/binman/ftest.py                         |  91 +++++++++++-
 .../test/security/pre_load_engine_pkcs11.dts  |  24 ++++
 .../security/pre_load_engine_pkcs11_pss.dts   |  24 ++++
 5 files changed, 266 insertions(+), 31 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11.dts
 create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11_pss.dts


base-commit: 444aca6d1439e4c4b9955171a7f45c053b540f69
-- 
2.55.0

