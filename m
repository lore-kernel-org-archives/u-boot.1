Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0015FC44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEE5A406C3;
	Mon, 20 Jul 2026 18:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4zlDKGZ5FKD; Mon, 20 Jul 2026 18:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35800406CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571416;
	bh=YAhUvMSw54viQx+Nfs0tptiO2KKi+yqgaGN9dxTtcn8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YCOfeRY4BRLGkuK0fpE2ahQWq5Q08VbX8zN8NCN0M/ovU82NUK3XkWAtMUJp0Orfg
	 Q8zNrpnzKdmyLSZFTKTFLIQDpS21iiCixpvTgxg07n3WCa7PADZHvT+FM1Znhi4D3b
	 FDLSZXx9BP8AsfTdLH9j+cd3aZUzZddcU9MZFNR0wQt6Y+r1jALahP4WtrK1kdVtEc
	 WBqnx/dSIMIL4AJtU0z6BQZ+iemZGaqcPFIGu/oOPoX/1eW2uPT1yEXSouinneLVMw
	 DQIKb2F3mINHn9KXM3byq3QtKHmcGvzh8a4dFqkGPpbsEbruwAzJHlcF2arHyVSOHn
	 8Osg2DM8yo2Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35800406CF;
	Mon, 20 Jul 2026 18:16:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 684782E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A0CA60703
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgPz_WIjUCFM for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:16:53 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0B06C606ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B06C606ED
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B06C606ED
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803A2844F6; Mon, 20 Jul 2026 20:16:51 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2844B80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:16:49 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69a50b818c8so17009270a12.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571408; cv=none;
 d=google.com; s=arc-20260327;
 b=NZHPzZcbNcNH2fE0VBVS/52hYSSx4ENSH300/sBDcu2da+4oIsonRLWADRXFYE9BX6
 OnuMATDC63dY3wcMP3sLw/EsaA8E9jALabT19EmZ0VKYRB9mVBEoGrd6Dnc+rbKVLqhc
 vLuZ1MGpz4A0NGPJeT91ibELrcmmg1RcRlxSDX/JApXcfi/7rFSxTWQUy30tGMKGWi3U
 WDhlsXtnDaanrMZkA22vS6oubbLjI03KKZdEE6RkvNI/9BDsmX4I0CBTZ6n4e/vj+cD/
 4ua6SC8eY16XMeF2eu1w1g8oDFTS7YU9Mc8ZPHup/svx4AEvj8YaJQepMy10esBKapSZ
 NHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YAhUvMSw54viQx+Nfs0tptiO2KKi+yqgaGN9dxTtcn8=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=HJq1Nk4Y0LBnhguKPzeB7xEm74UUbtjBnafIW1IWExxFU61zXo0Nxc5ewsn0b+N3Rw
 X7gW2pdjHcHQErdwG4txwmHfmZFU9X+uVvRqtWTMzjGoH5F5RlbtCbgumyRYQAK5Uyhj
 oqZYqGU09/cxvqIUZ9O14RWZYi50XeDiXmxRcx+Kcf7/9uC6gzVXnCJMM5ICNLoN3oIv
 eAKde4uAs7ionxj7wG/eqrK2tyMpXvtsfZ/dz6PC88M9RZ9ii+x+VUa1R2KKhBYhJncr
 9SyrSBMs6fPP4CrYVxv2OnivYQTS1h5gM/4j5OwoAMdv6LOtxVol6w0bsFbpMlbbvHZs
 G8zw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571408; x=1785176208;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YAhUvMSw54viQx+Nfs0tptiO2KKi+yqgaGN9dxTtcn8=;
 b=na35/ciEm1Y60zjEBBxzqACaz32xP9SnR2caIW041Z0Qq0KiKi1t1/xmhsB2oOJBfN
 QdTc56gJ/g7KJWRocTm+SXOO5EaLMQ2qa5YUQ3zOpXMD0nfzAVcitRME1rt4lIwHMTNR
 tMi77eGa5zrQuI/uIrKaFyY0JbM5YuaAWsgJWR1CjyAloTaYCHE8UP8N87Z+4E6j/5Sw
 QHMC9PBVfJZSLMGH5Pn4Mgo+fIOSlwRP1mJNxdrX/5iFrApTjHmfQY83VjndZo/Sffjx
 vC+07v8gZU9U2AOHPpNLqPzabOYRAkGe6xmUJ04atkoRrqP8koes6cQW64mid16lTnlX
 Ut1w==
X-Gm-Message-State: AOJu0Yzc4ckolYan2HY+NciqUnIJdGPl+nI7QwnaeaNHQExDcDTBeq0V
 s2JOv9AIDEU6DCdV4fKrD0GylqFRk8+lATLLcLrzDFpHsMiM1B/o1CmUMrj3cm/yLPS1jzrSYB/
 WV5TVdfZ7VlwKnKD0L3drHSJSsV/R41XNh7Z93a6J
X-Gm-Gg: AR+sD12Q3GRYZLgirEwqMZwZjlpek3ND8REeniv/wu+EA2Yo40BNKy6gwRMp1hAroeT
 9EZunObCK5tCSnkAd7Ki/rGyLKscGUs9tILqDbj1XNe7dyDsPLUEP6GmaY3tNzgOzt9y/WUNMsG
 NJO7qwNH5EjMDq3AM92HG5CYT1V7xKWCHmERKeRQ6WGkaaJVZOrRIRt9vkUfE5/inUIXys32vS2
 eSzdsXbXlzMuwZHmLGcMqynE4h0suRRPKOKfyJJIl2X0snciVY87Q+VUx/M
X-Received: by 2002:a05:6402:a0c9:b0:699:2448:be5a with SMTP id
 4fb4d7f45d1cf-69e652ed497mr5469800a12.26.1784571408604; Mon, 20 Jul 2026
 11:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-3-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-3-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:08 -0600
X-Gm-Features: AUfX_mznZWmmUFbF9MCGlNjzqWBXYT77ek3ie9CHcMCj75lISEv9149qEFkwTpo
Message-ID: <CAFLszThzOifNsfxRcgckrEYH_JXJ=oSxyOuAhoc4Qm+WW0WGnw@mail.gmail.com>
Subject: Re: [PATCH 3/8] bios_emulator: use driver-model functions for PCI
 config acceses
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571408; x=1785176208; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAhUvMSw54viQx+Nfs0tptiO2KKi+yqgaGN9dxTtcn8=;
 b=UR/lFiNvMgh7F0EyeGOBWOiTjM6ebYes2fyzVo2TvPVUa4k/xxZnL6cvmD0bt42tde
 GEAVkDfo3ooYNlPo3C3wN/ELrGgfHkm1LFE3HQJDcC2/kYicwG+gc6gaBNY7dOOquV1L
 I2k5MxouEgwXbCgoJlkP7io5sBXvKlqZ2wJxo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UR/lFiNv
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="UR/lFiNv";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: use driver-model functions for PCI config acceses

Typo in the subject: 'accesses'.

>
> To allow BIOSEMU to build without CONFIG_DM_PCI_COMPAT, update the
> PCI config space read/write methods in BE_accessReg to use the
> dm_pci_read_config8/16/32 and dm_pci_write_config8/16/32 methods.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/besys.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -435,27 +435,27 @@ static u32 BE_accessReg(int regOffset, u32 value, int func)
>       if ((function == _BE_env.vgaInfo.function) &&
>           (device == _BE_env.vgaInfo.device) &&
>           (bus == _BE_env.vgaInfo.bus)) {
> -             pci_dev_t bdf = PCI_BDF(bus, device, function);
> +             struct udevice *dev = _BE_env.vgaInfo.pcidev;

With pcidev available, the bus/device/function fields in vgaInfo are
only used for this comparison. Cleaner to compare the udevice pointer
directly (or dm_pci_get_bdf(dev) against
dm_pci_get_bdf(_BE_env.vgaInfo.pcidev)) and drop those fields.
Follow-up, not required here.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
