Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25755CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CBE284836;
	Tue, 19 May 2026 14:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4RddYQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE8984676; Tue, 19 May 2026 13:53:26 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4C8843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raziebe@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso2060293f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 04:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779191604; cv=none;
 d=google.com; s=arc-20240605;
 b=gi3Ym3t6AOwizizzPLJ+qMBLZoqDeHenADDmB3sDoCxm2Zbpd1PcS2izlio4JYovog
 0EXzsn/GuHtYCI5ksLl8xMvS0QGXh6CwAxkNXZEoTTJ16g1TNA1NolG4cZoYikm3sIVf
 /AfXkaQI1kny5mEgG1vNFmzLUb9s7gcNrO2puoVqU69mZ6B49g/LBMgMmaE/qoYtqXDo
 +sZY1OyiG4hyv/QWmZSsku7mgd5FzHRUbih7kV4VEHS40qdBT503lJ159xCJUDuo6ll/
 Ii5K5BAjtPgS4QGcnL5qvJYEuuS7UrMW2VbhZXVS4WnFisVHnedV+76zpR7C3H/ESbcp
 WEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=+PfgDq+Gxg+RWUjyMOWNP0q4yGbRY90P4ASJUXuhomw=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=SvE12tjJ072OmXoJAZijZ71K4EgHs/e0i6rHhQCZ8cbTFUPL0WVCzyh0XEriJqBmwD
 turGIlOXdr/SLNX/caGpa0fNjrs17skmdWGKH6TtlS1Vy9QRirlqvv/b1kUJGCWfTLyi
 XY5zVmfWNUqE3cym4PJV+6vDQtavkQ3tqwMsBF0ka08Dvyau+Pv/ZkCv7xz6J455Kgo6
 mbmfMF2ql9Tv2x/nFFGfih7IEcnPg76HGjIPCqSH5Zcjo0jKLYqaFTx2CeaM0GtCVlOq
 A0D47Nru764Czro5HqZVTbBKsAsVY74LbOSqN7O/OFrUWo6ws1A+KJC3PwHJ6klq8n8w
 A/rA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779191604; x=1779796404; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+PfgDq+Gxg+RWUjyMOWNP0q4yGbRY90P4ASJUXuhomw=;
 b=g4RddYQ7F31cqFSVmFoHqquUVVrgDaKl2A+2mAJSysZig22HpipI8mgAo73as8NUdf
 HFmRfEbW0KWW0ArGhYKZA+G8XOwjMPFqcuFNcBQ+55iKHs7sijwS+9b3jgUkdkYJUWT9
 0DJVm/AusDYi9xMG8MGwdOh+oDdsK4cIB6QyTO2enl+gELDYpYIJGjZ4JZc+gKnOocEr
 0+tCRQBWU4UtQTbJQZNfz+emEEwfxjpjT7X0zGymuCet6C6t3ZFk3HK9TKhVQ3Nn2jF0
 gRSdK0AzVsKv0V3GV2SkO+DyCUW+J/gM7PTx6PI5VFGkPuOvqUTGQsiQFz5brNtXrFMa
 ItWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779191604; x=1779796404;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+PfgDq+Gxg+RWUjyMOWNP0q4yGbRY90P4ASJUXuhomw=;
 b=gtSs044GqQlNYNVJzjUyGJc6XlMEOaMCFU6dEraAXdnfSG7mv1YrSm0hLv0UuJ5Ycr
 c7WWh1JiwQvEUcjt9OiPfXR6kUOrjHoSzAtwv98Dbap/EmxSvgCTMJ593PZh06pYhi5O
 IArC1l6RthjvK65crdJsc/CF3nAMelJ3ZbeP582VrpUd5La5fCThzsnV0nRFoPMH7H8d
 6x8YCkUELbF2GdEFL/v0ZDk/vCLPuxcZj+dX04dQ0ZXS9MqeTMbxSYZxqy8ddyG5p7NT
 n23gdv9b+osPIg+Q4XZ/aPoyDkJsfgsm00lzg8Wy1k0RuDHgVrEEjtN231dLRN6oaz3W
 gm5A==
X-Gm-Message-State: AOJu0Yy5nswQdCIzTyWckFxlEUrQBRubrcXlNnWs4b+cMy8Nb2pDVT76
 Pcv1j1XaeTyUBQb6QJeLmz9l8V6RHXViZmo4bCR8tkKUcorD481BIf/z6jRgh4viHZX0fKvKa74
 L4Oa803LoZhkQWmCupGLK+k+cDS8+9IvuSF6f
X-Gm-Gg: Acq92OHms2C76bsP4rhkB8sjUp7wg6GPnpflPRATlnd50nw6L/snbby26MeQKB86F6u
 858rQOC1g1b1jb8jmltbwgfVxjkVM3UQ00wUrwXcyHO4L6jDhGAhVVi1uAR7NpuJ8NwBRzPmqL9
 10+gPkq+rnGp1o7zMoskuBZqgYl7WwW3dCpaLGcxZ4qYb+x5+0khGDKGm3uRJCSIFKmcOVEKO6x
 QzAeTGcwsOkrHgmCSF/U/9ELwrR1eqT7ZMspu5ye4OIOsFzI6FCURISdqa8GFVlyZoy06599X8c
 G49JZQ71NDfYdJuYG8K3yqFyOsmZOuVuDxNM72Fb7A==
X-Received: by 2002:a05:6000:290f:b0:43e:a75e:352 with SMTP id
 ffacd0b85a97d-45e5b73b1d5mr31834198f8f.4.1779191604032; Tue, 19 May 2026
 04:53:24 -0700 (PDT)
MIME-Version: 1.0
From: Raz <raziebe@gmail.com>
Date: Tue, 19 May 2026 14:53:12 +0300
X-Gm-Features: AVHnY4IDvPy2SofaHz65u9AWyCTuRLD82w3TB8vfUUlUlJ4teLGoU685d-XMMSk
Message-ID: <CAPB=Z-rjEF5fCXcYWfeskz3W3u16FoW4VN48O-OZTz+fp81Q3A@mail.gmail.com>
Subject: UFS boot and UFS tool
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hey,

I have added a ufs_tool driver to my U-Boot repository. It extends the
ufs command to provide access to IDNs and flags. Mainly, it allows
creating and listing LUNs.

In addition, I am currently adding UFS functionality to the environment.

1. Are there any other engineers working on it ?
2. What is the procedure of posting a code ? Pull requests or emails ?
