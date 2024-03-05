Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A69C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1C58795D;
	Tue,  5 Mar 2024 19:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RRr2k4XH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01779880B5; Tue,  5 Mar 2024 19:15:17 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65FB880A5
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 19:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29a7be74fd7so638433a91.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709662511; x=1710267311; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCW1PpN9iniAKuvbhfk73sWujTUH5yfdSZ2JUHXN5pw=;
 b=RRr2k4XHOyQyknRTFb3h5RS3b58OyqKwZ2lUj7zJrhCjLh60K54lr8L52t5IyL41O+
 4W5pdBtPPI3t6DAax09McAZPQ4YoTu1uFdOxzJAh9IS6v6WLPLEdxePJ0EHHhOZoFqgK
 6TQL79pKWiSGoyKBMXGaHY6IvDn9fI4QNp1MtJoj4CN6FHUbVYV+/CWB0xJEogFNodws
 YgKXrigXQzZIp1wX9OvJrT7+Xu52GujVx1KfUYQfqyJgmbtLAChEseM4APn/2e3MOCQB
 y2fyHS0wwWFAS9cExz99w90BzLxwCBRQEyoXT1u3TgMdsjXttW94V8aCztxrqeTJBpDe
 e38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709662511; x=1710267311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCW1PpN9iniAKuvbhfk73sWujTUH5yfdSZ2JUHXN5pw=;
 b=Qj/hzTUiXzMtiSThhPSlcy34ndCd/EQc0mE96Gdz8z4Wi5w3RJ8hDz43BOK8oPmo8W
 Y8MxImCajXIno54Kjn+EFy9Ca/suXoEcTevJLLKgffSn9TwYD/ejlqQTHP88AT72KjZW
 6KtAepuJwkLaFM1DMsaJ1SdR/F41ItiqAWtrrTaPlt62HHi8EI1jN/sBCzOECwzwW4Gi
 tHYC1u318yXnGG4Cz5ZfTBeO48cmGN9iDdV3AgpLvrNHSPSyxcuuM9Sow8Ly+HX9PdA+
 R0zrRnV37o+BZ+735/4UywN79+ZFFYhsBy753xmxNWnpQVm7WiNTmKiMUCYZFqVlUDK2
 bdsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOGvORfTblcJD0Np4PiAEcrClUR9ypqwpfzpjt+diYJT+ZU6FKKNTK7ui4dIdo1HT0bQfmo6FmbfqrxLB1ZVfhUMyDAQ==
X-Gm-Message-State: AOJu0Yy8v9xZGN/2TwGaaXjlsGnq5Waib49VBLyiVgZ2hf9eFFbt3xcc
 iGC8uYUN9gGcgRX3DvASDrHt34D8XUW979XJ9EkKeAvE8bpw0cOAg6rcU85OQtKbBn6YOeCD03a
 gsnsfFOCwp+yCiLaiKBsO054kZlk=
X-Google-Smtp-Source: AGHT+IEI3TA1Zp6CetMW1KWpIKLNjNjrwDKfiaLzY+lAxhG6Ntw63n2nWRUIr3NU5volq7FTdDdwFNIFSpefp6nPY0E=
X-Received: by 2002:a17:90b:2c85:b0:29b:3125:47f6 with SMTP id
 sw5-20020a17090b2c8500b0029b312547f6mr1328546pjb.0.1709662511048; Tue, 05 Mar
 2024 10:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20240304-fix-thermal-driver-issue-v1-1-f30daeaf1055@phytec.de>
In-Reply-To: <20240304-fix-thermal-driver-issue-v1-1-f30daeaf1055@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Mar 2024 15:14:59 -0300
Message-ID: <CAOMZO5B35UBd5ZLuxxNx5Ai_Ao8BFVwn7z2hbj+Ewxw-GsmnSw@mail.gmail.com>
Subject: Re: [PATCH] drivers: imx_tmu: Select polling-rate from cpu-thermal
 devicetree node
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 4, 2024 at 8:49=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> The polling rate is already specified in some devicetrees, like
> imx8mp.dtsi for example, but was not selected so far. For the
> trippoints, the cpu-thermal node is used. Also get the polling rate from
> this node. Use the default of 5000ms if the polling rate should not be
> specified in the devicetree.
>
> NOTE: The polling rate from the devicetree will be used after this
> patch. In imx8*.dtsi devicetrees the polling delay is set to 2000ms for
> example.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
