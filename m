Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA79C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 23:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7CB889FC;
	Tue, 20 Aug 2024 01:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d0SWC4+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DA5885FA; Tue, 20 Aug 2024 01:15:43 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C814088286
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 01:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-709485aca4bso2421909a34.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724109338; x=1724714138; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H/p1Gq78vXQYf9qBkUSF0Vx8gjLxanCSJVBTUpSEhVU=;
 b=d0SWC4+dZkBQpJZ/xqxFB9vmcaSjV8yMsCNMeod1pRAAjkugF6PpqsBpuRCTXBz2aq
 eb/FbJI8+HJ05fqQE31Zdi23DT5nW3jSctnkZnPVi/y+/OvJCBgKxoktSJ9RV9xtHYav
 SKbRkxyw9RX6NwV8VfNyddAhp5JxkN7Idgp/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724109338; x=1724714138;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/p1Gq78vXQYf9qBkUSF0Vx8gjLxanCSJVBTUpSEhVU=;
 b=fbsp0X7Pde/8FeQ2oLNzXoZE0ny64sM6iKApK8AoxSeEWfNHu0MbnsKbbOAP+2cBd0
 i7DRBXAuETrWPUx02ZcfZVsNhW/UpxvxlN/jDvRok/AYzgVrIznboZmJi1MQVj2KTPWd
 0q+6uzub1v5NWyMXZ4b68/w+7qPd/1E/xMK8MWadFI6Y9lbWjHwvccGbCgcQmElX0qm8
 rZ9cD/lKtysSqjGG8bJcgabTcNlTI083ZXCZtqNyCwyLfiRguTn+Uya6oYZ27eiNitrp
 A+NLfIkSxw75X6TG80+XL75yMJnrVLPDyhFHxksQ9TSIs46i2CELI3J9E4n5Z71N17xN
 DkIg==
X-Gm-Message-State: AOJu0Yy6vsLo5mVYmzs6nuAgxQ6sIWBPOH0qQmyzjSywiEaLnK9YQMVr
 k+VR+3XUkkjaLaIlriikn7sYl5AmfhERZE0mPcdSqnaaJfM08BmtVsPYJOky/IMe6Nm5pB2wSED
 D
X-Google-Smtp-Source: AGHT+IEIvIfcfC+h4OGFLUxLRTN+ZHbyHdlW0uro1MVRcTXsoINBhat1c4acKdhWR5uhe4/guZkKTw==
X-Received: by 2002:a05:6830:6a8f:b0:709:6889:6d50 with SMTP id
 46e09a7af769-70cac84d7bbmr15526172a34.11.1724109338560; 
 Mon, 19 Aug 2024 16:15:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6494656sm2478209a34.19.2024.08.19.16.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 16:15:37 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:15:35 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10-rc3 released
Message-ID: <20240819231535.GK1626301@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Q/XpYxt79qiNnM7"
Content-Disposition: inline
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


--7Q/XpYxt79qiNnM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc3. Things have been mostly quiet, and
with the -next window firmly open I believe things should remain quiet
moving forward.

In terms of a changelog,=20
git log --merges v2024.10-rc2..v2024.10-rc3
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday,  October 7th, 2024.
Thanks all!

--=20
Tom

--7Q/XpYxt79qiNnM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbD0hcACgkQFHw5/5Y0
tyzY1AwAhmMIR0neoNHTNzf8OGiepWSp4SwIwo827BubDRTwdEK8gkhb+yiGGHR+
cYv7Kuju3PKNvDrLnEouHQFBxfwuJqCksEpmbcuYQ9l2APWe1vt4ha4hvtz3wKgg
33MRBK0Ysom2T6dYh81Cil8ctqEPx84rXQ94v8vRKd9FHXJWi0f3sPYD7wX1pqZM
/2oRzx2jOtYVS+0huyBQYpPk41tLpFRnh0pR9cFE+f7QbeB2gpomj11iEzVoNvfq
vhUPuTEoR81iqs4/R41ZH/nZaXfhZSCfDNHfF/nIvZX0SciS8UKdOZnM0tyQJXO/
wvbzf9HiY6Xq8+ILFTLHyB3B7VN7GOedTstbRK0MC6iHZS9xnD8g379RQXvTUv1E
pYVLF5I6yc2QHFaZxMcvqMs8xzS/f6N8uKTsxDTw3/Q+IucnqXnwR19kTffN52Cw
8YmHsPTKCWUWvQ1c5N5yTJSwkBiGoTZoBVmjdrZFebJYc23rV2/G3/nLwEX2CTDq
OjUJuw+f
=mrJZ
-----END PGP SIGNATURE-----

--7Q/XpYxt79qiNnM7--
