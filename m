Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864A7F327BD
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 994EE83FFA;
	Tue, 21 Apr 2026 09:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MyptfT1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DDE684370; Tue, 21 Apr 2026 09:59:33 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BEC83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-676a89de629so744150a12.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776758371; cv=none;
 d=google.com; s=arc-20240605;
 b=XY28NiaYvq6/UzWlWFGr1SvinlXEXGn8Zz17H4bI4K422pcMhz0o4uc9FpaebzS45p
 NVoaETaichIYuf2va3BwfepTf948vuWJV9u2mPJfI6ZvIxA7rqhTV4YpCYu2Z6K+pRzU
 6zpuFptYAMm1XuyoLLiWCp+YmfPLIQj1MazIOUNw6c3FB04QibW1Pqm14PtzT5w4Jnbk
 K/7MCbpp1g8Fw8WhHC+xXl6POWYFADKDeclYhoIZrgKAJ1oT62Bz+dY2lHYpjX8f3fQu
 QrG3ZWcdOibElStJGUG4pGEPi0EqWUVjkqwIXmX3Nzx42L6tRKtc5kC+pQdo1HaMifOB
 /tUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+edRsPYdUi00c0lMKRPG3S1izw5hTOaQhuY5t/7H40o=;
 fh=dMYkw2KzUVSijECylm0FgG0d3YJhop4TnuFXfdv1L8o=;
 b=GMmjhtAIncqQbL1v3ueh5EZhX8ZVYUe5Axr2gTXbCZVNPt4o105Ug3TD8mQS8nA4Uu
 ebCcHxazcQ19x2qxPRNdI136qJrMowvnvXq64V//laIZsFfzwl82XpIkpi/5jAxDkL7P
 6PoGQLI+8MMI8pPHpk9Oy6CLNJv1to1ZeikaZD2hes6eINifLEA/0yx5TlPpjdb+Dvhp
 YiUJx+TkSLL+nmVWZFXLAfLhRF9TwbT9LQ7m8JXeAki74fpBmFSQvqyUqy+XlymBh8Q4
 DuTWXzLXqhSfOYFc19H4nUxm80hx5wwmuSi4Ux1sC+japDzW23aDAUqzi+FVmeDYZF2+
 8iQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776758371; x=1777363171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+edRsPYdUi00c0lMKRPG3S1izw5hTOaQhuY5t/7H40o=;
 b=MyptfT1VxUolD65IXOvg/w3CP6f8ZlKWRnO9Kq2eNn86ZWIJp5Fg3S/1347JRUvV5w
 aX5kbURVWRrE/zhwovH1GQkJth7l7mosZgWOsfHd0d+dVHKsLwcxpXSQPxwkpL7ioea9
 xcA8NahKCz8LKCAzVQhosMCqiQ6TB5wdaOXtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758371; x=1777363171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+edRsPYdUi00c0lMKRPG3S1izw5hTOaQhuY5t/7H40o=;
 b=HCjgZg/oVeXnjA1o3XmrnyuHyCvevE7PdM3ZAZkxuh7ycN5Jr8wrXnL4twU4E5rciU
 Rdo589G+wGIzf8K7NsE2s9p9Q0wugSCtUPHAWtnycYgZ5OpHutgh4NDNSjZjyi7bhAV0
 VWAL1NpW1fKCHYduQcyfOQuj+uKTHiPDAbRVh36VAa7MdO0Kr+2LFQAXtWK/miT050WE
 eQGMHDIboJbNsqVIhXHc9kF7aB4weXzJuPDbhwTfZRgT+dd9zYnytBpDYAbwksOvpfdc
 bM/VWsKVEW9oaxILaUlCkYWJusYeobiaExbyFqJFaCmMxU9UQ7TKDX8N4tEiZa6ObaTE
 dbMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kcxZS28gYvA6Vx99EpyxqnKvQIWSiBElZlmJpl7IWQ88Pdspu62snqRqR2x7gM9UXA+KNdA8=@lists.denx.de
X-Gm-Message-State: AOJu0YxSOOhfuLHwWhaE2TiHxFXG+b1R50KrTD5zvvdvQqjv1L/lRCb/
 azsmhAtAdBgOSq9SQWCvsSH2GNXeR/INkEdlYIizIFquoNaw3+EGcd48yUn+/lfG2+OMc7rdk7t
 wp795N7zJLkFk4st7zmU/vqtGSY/2w70mCs99QMpb
X-Gm-Gg: AeBDievUci6M0ye7F2lfGboa9PTRloVxOZoOA9OFtACHyTbh1xe8KWHseA87y48yXPp
 le9VuLFXPQX96q0ZgBXXkqre0MOP4JgJuoN5I803/AoLzhLrTxMoWDQPKrlgPBip1c5DVmgjM0S
 BITFzURHatVE/7TI8llXOni1VVoxg0J4axONroOo/fN+KY5PMUuzevcMwUcHdvJtj7GuYfqui6y
 X3Qy56oQ79fIqvZZDIg2ZQF9FSTBODverxsqL9W1WVMQss4Nx3FcqJCyfNFarUFTTVSvzxlII2e
 9QlppXJIFSVyx48nXlYg
X-Received: by 2002:a17:906:4fc5:b0:b9b:ddb2:b1c1 with SMTP id
 a640c23a62f3a-ba418f7f625mr716548166b.21.1776758370820; Tue, 21 Apr 2026
 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
 <20260420220321.71147-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220321.71147-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 19:59:19 +1200
X-Gm-Features: AQROBzCBGSE0fCineV5N9_Pfm987zR78olef5ia8lkzDXcZyULwfU2up3TtdxkI
Message-ID: <CAFLszTgeVUD81CdzhaL66ngdAY_pXkYaPoH-VTOUBvyc2WzUxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cmd/bootefi: move efi_init_obj_list() to the start
 of do_bootefi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>, 
 Ying-Chun Liu <paul.liu@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 2026-04-20T22:03:17, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
> cmd/bootefi: move efi_init_obj_list() to the start of do_bootefi
>
> None of the bootefi commands can be executed if the EFI sub-system cannot
> be initialized.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> cmd/bootefi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
