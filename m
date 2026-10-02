Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6ABCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCC2060894;
	Fri,  2 Oct 2026 11:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVA9F3TqA8T1; Fri,  2 Oct 2026 11:24:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02DDD6071D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940287;
	b=EYW/nuW9oXoEM8YzpxEB5P5gZmkbuVB6loq+gBh8oLwFq+qyzfYulKjvl0sSaISniwUB
	 swjtcOnrNbQrU/C4yn+NZRcBgPjlytrkre3QD4MPGKkbB+2g2pAcPFJDyW5zBV39+lv6K
	 22FGfmJK5N0SpVP7V/8KzoeJGuN0ihyvCj0dUKZ1QSw8TysvT4P8RFRTk+97ID7WLq77f
	 x6WLaUCDdamxhAYzTRDq7cQTAHK3/s/eAD2gqjOn8GB4dStJHDMrHm3gBDDrpry3TMpaA
	 kZtGhSpLwm8V6rkGJ//FRlvIgXkZvWvOAm94GDjDZUwkfAuZVFEi90aITNnXaw3U5Gg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790940287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VJ2tpY/ucLi3+RaCJPyECy8k0blfL3GZiiR78JU9UxM=;
	b=sM4RIqxsP1QCiNwRMBz7ZBrNmLQHCN5fgPS9xubVRuj/eEs7F6UmIU1so44/xfNH1dse
	 7trEis5rtHEFMkFMbEQE/enUJ2GU2AlvTmndlLEcpFqlhgfKPoV8u6bh4RhNjnqNE35mi
	 4p8yiTy/Ai3eTVlco8OBpR0XtT3ueYxMmahH9fVqogQFHYsfCwLhrkaAVPISt5wZk6kzm
	 NbcOKftXCzOkx0M3HmD+zZ+xthvLHKkk1z0eC2k4pj/OFr1Ifuxeu1Idh+XQEeQINas/m
	 GQt8lAjHOUs9To+OXcsPfBk6pWGJ7TANxat7rO2BscZTECrr8MBFsnzdt5WI5cO5mGQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790940287;
	bh=VJ2tpY/ucLi3+RaCJPyECy8k0blfL3GZiiR78JU9UxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qDuJvYhhxOlj89JsdCIqKiJBuqeIlG6o1sgPwV7D1cEulmynXNPoPZc4KNVo25g9g
	 pb88qNGCnMI1whPzPxWJ+bvmf4GcrS69azr7rLmvITL1Ktlnj+nUI+mLM5skA7OfYO
	 NFc1kq4XxvcERHB8UiwvF3cbImqqeoFrvHihB2I4kzS83codwsTrw+oQmIVSf1CqKe
	 oUS94RRbK8sN5aZDah5EZJNhNVARUBqmozrbxxdD7AtOn0RaA0AFoma0CUO68I7a3u
	 EnaCFjfSM8NtcECqkgLa/uGeKLuxRd7SCmgDOYu7dOLJ4VQxAwY8K0ica2/bPB9A1n
	 UNezX3V36v/Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02DDD6071D;
	Fri,  2 Oct 2026 11:24:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E24232F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7411440D1C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ckR8VNoWsis8 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4BB8F40D19
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790940284;
 b=Ie4VFqxB58Lem8ofI2TINkmu8fQljRPMzLRQEipE4aYk+wK+TDSOpXFe7Dkc/alZZWgO
 KCabL101gW4tE1tibobxYUAV80BY81tLbkbBN65e+69HdHJ8DGGaBYBqay13u1Hv9lTOF
 znqZC6+u01voicHA27vZpjQ01RJ3SJw3lwifpyLCje1v1IAogzlZyv3PtCg6TorjhvcRH
 vgpInAgSr93PhsntQaoE8G+941SdNzyXWRxmdhGDknzbX1maaJvHOXFfvdCNMVZVLs8ez
 xje0PGvt6p3S+Zwa9cqP6wgHdFg8n+RoA6bj211sAbxQkcTx6gak6J/4p29Bh/zXAKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790940284;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=VJ2tpY/ucLi3+RaCJPyECy8k0blfL3GZiiR78JU9UxM=;
 b=UOElq+QG5W7q1nr5aFcZ7zc3no0ImOQ+shi+GrPX1P+8wqy2a51CPqqzyVoWmwK55q9b
 pxbDxzWh2+1nEsorh3dCPdhDKoOZEWUut9gthsJjtpIf83SF9+o4W+PO/wsVXsfZ8SP6Y
 mRn17Gce6IkcnarRRVoAHBD+7V53RG3+R5dnqbgcW9SXiL0snE/wNc/DA4NYkZZ2NWb3f
 yOmVo6JIubxisDUaBlLhuMOp0Eh7y1CgU55ifzZTU2Y1280uDpm0mGoCS5wycQgAA9bl1
 PgV4/NkIMtLpbdeUZEv4Qa45Eu09FiUwAb7SzoZtS2D4SEnb1/BbZpoFNNumyIKXkSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jefK3EJ5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::c;
 helo=mail-yx2-x0c.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jefK3EJ5
Received: from mail-yx2-x0c.google.com (mail-yx2-x0c.google.com
 [IPv6:2607:f8b0:4864:41::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BB8F40D19
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:24:43 +0000 (UTC)
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8abc87cbd93so31647837b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790940283; cv=none;
 d=google.com; s=arc-20260327;
 b=oL67U8xUEcOgv5BxxOUcthoK0rfgC9/7leAKt9vQkiZwvk8lggNCmE4n93oLY3BGi4
 w0hPny/aUoNz35+uDp37ms4kNqDUDfsLM7S8N52uTOAdieUQZ/yAbSL2wrDOLDmHZlIc
 oBvvzbA0J+/W9TOOhWeRXWjUdJPTkZgvgWapBZ80H93M3xGqbJFu+hATvKmVyT5gisJ/
 XCk/D2lscjG9fchGExx51KV/rBAOs7hv9R/ZHrmJYaISsSHWkxxHvg/yyYEwDRVzrJRF
 l3SIjjGGDx0+8NzV0jpDOv6WLqdPSSM7Ktye8ZpFJI/W0s/DWKkwDgVSx3Mc6uVF9nf4
 RkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VJ2tpY/ucLi3+RaCJPyECy8k0blfL3GZiiR78JU9UxM=;
 fh=nuBf3wKo1f6h1jUIZsacuBBNlSv8DnOg+7qF0rK2IQQ=;
 b=gFoGojlTVvmhU0EKI+NlHsnvohPZISkBrThIVUI/4+rq6caNMMBnhE9AWIUCnVefYt
 V3scwnbFvH2YLn7g+QvvmOW/lRsrbLZc79KwLMoKIhlOm8gRPHF+prz68RW8oGf424Db
 W8rijwVLp5ZYmiqHlIWqpk7O/IFeOi/py5xh8UuKnUoVfs1uLNWcJImkyRmPkK8F7ZZE
 NYGJ3RFmpkI8ijRUAuOBU4HIjGauzvrzP5AMbE2oOibytkZfnMg+qZ4mvb60ajA4sr/9
 lcXYqKUoF+oBxvUkBj9f9QG1mpNOmPouqhUzMuxAC2ORWVUaeLdnrRKAgjSyrP25uM78
 Vc7w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790940283; x=1791545083;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJ2tpY/ucLi3+RaCJPyECy8k0blfL3GZiiR78JU9UxM=;
 b=jefK3EJ5gv6GOWKDDKDI5VJkVbEx+EHA+QBPJHZGRXDeh7Mb2AHcOZgpnjuH5GRXrT
 rHOYLv/ck26yY/cKc7n66UCHkc/fsNnlsoZ3taI6aB8W+6TrrJAIgsXy0pLq03KkkdO+
 iKGux4N60Fbyj3kDEcXwDaJZc7JznkcSGQvF53J53+g/IVAXUV7BZGQyl8CK4PbSi8TU
 02g4aWFIrGe3EfKWdSjKTKw1WCFcZVOZNI3hIIcuBNGpljiu4aFcuIZKQDCuyDA7HOja
 yVOchxnYD/28mF4yhPg5XWvP4FyDBNiFZKi28NSsCpPkRS125VQcvBH4+EObNLrq5TOO
 z+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790940283; x=1791545083;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJ2tpY/ucLi3+RaCJPyECy8k0blfL3GZiiR78JU9UxM=;
 b=JzKjtwpHvurSB6SZyR641+On/Y/Wu4vfCc0sWyISXOSH3Pv7nPlCi+i0yJjdxkUuv+
 cjsNPPQliR0VDy7La5DLhrvILKK0LpZ8++fBvRZ6DP+LB/od0dnRAETH8awK4GRu9Rs1
 jMV5S8Fqd3FF+KXHSB1kRfeqkCP5rMkoR5MOu/9NszEkf0DZCXicRUPVeGpEuf2pyG6e
 49NQywlgal966vKZ+YfFpdPa/XbWtJl9gjGYWVSayUqzpCtEsB7g+v+3bt3tQq9T9vwe
 SbF1DAOisDhGZoRpOwDZovhv0vuSIMBCL/aHMSbqmQn776cyw40H1ImYLpvcrYuzwCdw
 PAzg==
X-Gm-Message-State: AFq9FYJshR2PaKuWKVJ1fSTSh9RGCEt/dGpedO/SA/ELlloQJ6OjEgfS
 +8MfPeIKJ9XgnHNBtd20iKd5pSjiJxCAY1EU5BBdxj52jEN+HFdRpTfWzj0aeh2CyXfX3L7SJ0a
 KjkbhUJwOiTBpQfwg9YWiYD/zyh29pMLSUIbmJ846RQ==
X-Gm-Gg: AYBFou3mDv+kKxv5292Nl6sAbYwKwi7wPMs33/3Ly7Ps/r6I/2VKzH5BtCmfYzfy1Hx
 tPrI2IE1TEigVbWpxNuqpXBu/+irPmkbypYKoXQu/43QT/miwdq7wcIBoyGW/jfS6rT0Y2dlZZ/
 BHrMsCTqi/pUmMojfcEV03KBFMr4X0vO8SA7vAGUlQiLq59qoGuACO8iQmXvXoKQnDtnJxltaJG
 6UcguO6FYBx8AlxQ0bCLzltlTo7NF9WvBWg248KsRXNJ0D2qDv9xc1nutcM1J5a/ZaN0aWTINvb
 3YyKXD1lPkwwk1gNuWtkdiQWrQW57fzh3cRSF4hKRZbj7Gcf875bU6dQpV52xdn1Pznor3O+POW
 TfxVOrnenXHy7t0mun4eC5nBSkKy+V85Fx3c1oLyUzZ/VdN0qSZGG++NRn/GymRo5gxJU3JaiSB
 49c6ONPQnpekaS7z7FAx5wVByHAcmvXv8pqhwvNqejc0pxVuM7TsMl7jIXxcXjKyFE1+9zVdMmm
 tYAuxEWKwErsvRVoPjxvlW1dBuamZj3IBivst2K797AmNWkIXQxWXZI81HGJQ5tbd8ofXNBNHPC
 vBplhCU0UhVASIPLcip25WzlG4J76f0A+Wg4Fh7VxS4tZ1VFVqCXVTFEjcOHpXn2v4ngA7UTI6y
 8SwiMg78JFK+xzKi3c1Fd1OWkWaLSos509Ump+qAYAcu3UyL/In08Zw==
X-Received: by 2002:a05:690c:e217:10b0:8a8:90d6:5754 with SMTP id
 00721157ae682-8ae3aee0e03mr6192037b3.65.1790940282517; Fri, 02 Oct 2026
 04:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
 <20260921-conform-v2-2-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-2-daeb00359af9@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:24:06 +0300
X-Gm-Features: AclHuK-BTyURzKK_crzU-JXR_7Eq3v41R37b6XXEDbF9ACkRiwAMO7J7PjgZ3vw
Message-ID: <CAC_iWjLhqHRuPfxp9vaRP1pvYbfwe4pZgVgK+beayqNNbpTwNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] efi_loader: add EBBR 2.2-2.4 ECPT entries
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 21 Sept 2026 at 16:12, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> Add three ECPT entries for the EBBR versions 2.2, 2.3 and 2.4
> conformance profiles:
> - Define the three EFI_CONFORMANCE_PROFILE_EBBR_2_[234]_GUIDs.
> - Introduce the three HAVE_EFI_EBBR_2_[234] non-visible configuration
>   symbols to compute the actual system conformance status with the
>   dependencies.
> - Add the three EFI_EBBR_2_[234]_CONFORMANCE configuration menu entries
>   to control the addition of the corresponding GUIDs in the ECPT.
>
> Following what was done for version 2.1, as many entries as possible are
> added optimistically by default in the ECPT, and this can be overridden
> manually by the system integrator after inspection if necessary.
>
> Conformance cheat sheet:
>
>   EBBR  Additional requirements
>   ----  ---------------------------------------------------
>    2.2  TCG2 & capsule "on disk"
>    2.3  Authenticated capsules in FMP format & boot manager
>    2.4  Non-UEFI (privileged firmware)
>
> We do the following configurations dependencies approximations:
>
>       Configuration symbol  Used to approximate
>   ------------------------  ------------------------------------
>   EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
>                     TPM_V2  A TPM is present
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  include/efi_api.h                | 12 ++++++++++
>  lib/efi_loader/Kconfig           | 51 ++++++++++++++++++++++++++++++++++=
++++++
>  lib/efi_loader/efi_conformance.c |  9 +++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index d4fdd50c49e..17e55118cda 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -238,6 +238,18 @@ enum efi_reset_type {
>         EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
>                  0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
>
> +#define EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID \
> +       EFI_GUID(0x9073eed4, 0xe50d, 0x11ee, 0xb8, 0xb0, \
> +                0x8b, 0x68, 0xda, 0x62, 0xfc, 0x80)
> +
> +#define EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID \
> +       EFI_GUID(0x7721fc77, 0xa724, 0x11ef, 0x8e, 0xaa, \
> +                0xf7, 0xc9, 0xb1, 0x94, 0xba, 0x75)
> +
> +#define EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID \
> +       EFI_GUID(0xf2bb0422, 0xda8e, 0x11f0, 0xa6, 0x7b, \
> +                0x1b, 0xe2, 0x20, 0x85, 0x40, 0x98)
> +
>  #define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
>         EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
>                  0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index aad8f860868..81231533946 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -577,6 +577,26 @@ config HAVE_EFI_EBBR_2_1
>         depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
>         default y
>
> +config HAVE_EFI_EBBR_2_2
> +       bool
> +       depends on HAVE_EFI_EBBR_2_1
> +       depends on EFI_TCG2_PROTOCOL || !TPM_V2
> +       depends on EFI_CAPSULE_ON_DISK || !EFI_HAVE_CAPSULE_SUPPORT
> +       default y
> +
> +config HAVE_EFI_EBBR_2_3
> +       bool
> +       depends on HAVE_EFI_EBBR_2_2
> +       depends on EFI_CAPSULE_AUTHENTICATE || !EFI_HAVE_CAPSULE_SUPPORT
> +       depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT || !EFI_HAVE_CAPSULE_S=
UPPORT
> +       depends on EFI_BOOTMGR
> +       default y
> +
> +config HAVE_EFI_EBBR_2_4
> +       bool
> +       depends on HAVE_EFI_EBBR_2_3
> +       default y
> +
>  config EFI_ECPT
>         bool "Enable the UEFI ECPT generation"
>         default y
> @@ -592,6 +612,37 @@ config EFI_EBBR_2_1_CONFORMANCE
>           Enabling this option adds the Embedded Base Boot Requirements (=
EBBR)
>           v2.1 conformance entry to the ECPT.
>
> +config EFI_EBBR_2_2_CONFORMANCE
> +       bool "Add the EBBR v2.2 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_2
> +       default y
> +       help
> +         Enabling this option adds the Embedded Base Boot Requirements (=
EBBR)
> +         v2.2 conformance entry to the ECPT.
> +
> +         Version 2.2 adds requirements around TCG2 and capsule "on disk"=
.
> +
> +config EFI_EBBR_2_3_CONFORMANCE
> +       bool "Add the EBBR v2.3 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_3
> +       default y
> +       help
> +         Enabling this option adds the Embedded Base Boot Requirements (=
EBBR)
> +         v2.3 conformance entry to the ECPT.
> +
> +         Version 2.3 adds requirements around authenticated capsules in =
FMP
> +         format and the boot manager.
> +
> +config EFI_EBBR_2_4_CONFORMANCE
> +       bool "Add the EBBR v2.4 conformance entry to the ECPT"
> +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_4
> +       default y
> +       help
> +         Enabling this option adds the Embedded Base Boot Requirements (=
EBBR)
> +         v2.4 conformance entry to the ECPT.
> +
> +         Version 2.4 adds non-UEFI requirements.
> +
>  config EFI_CONSOLE_DISABLE_ANSI
>         bool "Disable ANSI escape sequence queries for console size"
>         help
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_confor=
mance.c
> index 470141af483..c1234681bb6 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -29,6 +29,15 @@ efi_status_t efi_ecpt_register(void)
>         #if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
>                 EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
>         #endif
> +       #if CONFIG_IS_ENABLED(EFI_EBBR_2_2_CONFORMANCE)
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
> +       #endif
> +       #if CONFIG_IS_ENABLED(EFI_EBBR_2_3_CONFORMANCE)
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
> +       #endif
> +       #if CONFIG_IS_ENABLED(EFI_EBBR_2_4_CONFORMANCE)
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
> +       #endif
>         };
>
>         ecpt_size =3D sizeof(profiles)
>
> --
> 2.53.0
>
