Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC537606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=saU0IF7c;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZo8Gpw+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC99480E0C;
	Tue, 10 Nov 2026 08:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lg5QbU4nDJ4J; Tue, 10 Nov 2026 08:51:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 17305810C7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794300689;
	b=EbfxjNTJMT8uHK2v/wC9UGbba9VHDbUa7t0nNaCK7+wtiCUcFrkp1m/hvCU9KYe21aM8
	 wQYOuWmX4broICu+ZZzYlli5TTRs3xhRO3RQRqLsn85Rjj0fXivLhv8iKcjYp0g7YuWB1
	 CzefYy06WcHB5uZxhQOI6tQrZWrRB4fMsyOanMS4y4DJIUDSVyGJdy4N/3El8lPunGLN2
	 5KYFPsXHYTxI/puAO6auiVEtUgGCNESiS6yOvKy5A30yDV2ujk2Tg/NdRrqSTkOojrXK5
	 iS03C4Xsw36/zS9DhDIYLogGia7Pef8R0CEaB5XT+558ArtSKyF3N4G0QCTS53uvKKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794300689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MPGn1WJAyng6NRc9DLmAzGgio6wn7QmgkNErx1nyDIQ=;
	b=h57zIjDCWT4uUW8TcwlMPKOBUIzibjT71qfZYB7QMV3VUDHUitTji0fIdAv53wQqfr0H
	 EKA+2+bhoz6QJ3Cq2t+JANLrLdfJM5imIn348o98NZ6no5gRiMP8I1ypV71DT+CDwyVXx
	 snaCDXNV3g/UufqMpxFCAFS+cORBpqBVJ/V3mMNcONc9hKZIb/sP7PRFaDk4rJb6qsN4k
	 3vH+6Bq9YOhiMaGKw1fpAI7428AvTqZGJzPSwH1/sKY7T3UOVqOzp6MAWx0FrmeXufHaW
	 aAfG6A7Z/RFABLem6e5x1aapMbC+VmR49Vt1AFAzy6ahVmsH1e1qcHR0wpx0SYMRVoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794300689;
	bh=MPGn1WJAyng6NRc9DLmAzGgio6wn7QmgkNErx1nyDIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=saU0IF7cMhFA+u0wR3SXRHk3ssX81JDvpONPOIdXeEsorCbgVUUmhFWWlHmvmKQAZ
	 /PRQrbwjKpHTsWv70tjag6Co66JIupLN8Sm57sXhJCwoQCB/lbO8sH2RqdJuMb7E3u
	 EP9luRPrO6/gzNKomjTcBwUhFINrWA4XhTuiXJ+pHPlrMi16aOr5ScqhsoivjOFiKN
	 LSGwkx/D0GQH9j/BxLY5BD3TuFC+y0SPB3bbkG3ekmRALZL6ZE8e1fou2dosWZ36bG
	 3NvYoTem/Bk/DjOpyhHVR+TpKdI0cvJZnexrE2UrBgQrkmQTusG90jnLru1fnDKREW
	 JMq+ruOXSIeYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17305810C7;
	Tue, 10 Nov 2026 08:51:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBB2A335
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC0AB60768
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJMEf0Vh1LHi for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 08:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0625C60668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BZo8Gpw+
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0625C60668
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:51:26 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-36dbde64409so3600462eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794300685; x=1794905485;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MPGn1WJAyng6NRc9DLmAzGgio6wn7QmgkNErx1nyDIQ=;
 b=BZo8Gpw+mFiroEE6fhDy0MYDbu527CvUMuEpnVu37TjVdqrWx7dtKRniSh4sTaCZsv
 PBt32jJ9+R9EhMBoPUgyPcLqLJSlo44QGqcT61sbwTtGspFlkXADSQFh1jLlDUgBuOm1
 42BBqmLZzYaP1hqZRo0aBQYHAJZhpEZisbWUpghGugCEBcc1yUXV2+gdUQfUDrRPZGbR
 5Fiw3sz/bU4RRuOac6ou29fb6WZFFr8O0FE7MnVh3ui9K4hoTWx4z8smLKDSPnXP36hS
 vgTtM5wbBtGDr34lnbhCYfUKVp/uD0dZOVyNUd/VewqBkx05LfAnixKzlRdKHoaVxOd4
 I8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300685; x=1794905485;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MPGn1WJAyng6NRc9DLmAzGgio6wn7QmgkNErx1nyDIQ=;
 b=EsUGbKlyWC0FHPXFP5kRKhFfaZ32RX20n0pCYRNdyt2eVRORVYNAFDN8di2sol+Q3y
 dfGLBRaSxJNYm38mDEJqwNF5zm7wE/jB7M6DCex4xPD4Chq2gJvp5T6PyEXtIzOhQK4M
 HZefySvWGzftwtEbWzmfKjhsyRvO8CsfdPVQgWpWhLZwezp+AUxGAdrepor9XuxXXmjR
 wnhfALC/SEkEhu+kn+ZL2iixFh6HRVefltN/qF7cdwwKHINNd+uUn/wygWAYDlHXO+Ue
 JDS/HbwTU8+07Sghd1gUf15hrOZft1GZ5ozP09QDXm5MDQtELb/mOPMS8EfN58MYsN+3
 mjVA==
X-Gm-Message-State: APuU4Z83aZwgVy7g1WyLPcxT3HIq3LsHJrCaLSesj42TSo5tYBYG6XmJ
 YiYqFkjAkrQvySET0afDOOOHooZ3aGScwIWH6h/Gs1DSNx5mLMggbThniEpWfAoeVIpGH2usEwY
 DXUFsPnt/cgTJHExUi6ZAuk61nIsFcOE=
X-Gm-Gg: AYBFou3lOCvXE9TBJoc7XvD6e0JksNL0wkHCbBjgxse4LBTqloP9Z10EM4dGrLxVt4P
 gF8nU99K41pRvhibo8xSbBdm7+sJPitBzi7IDFVcb0He9v1kk6wuAHOv0IVDq3Jp2QC+br1lfLv
 girX3RqWVD72m7OR8cy6VKujW6KlNI0MmhisiFkxSxOMbTOp17a2uBFRa9+hiSZNHRFIeQrPPmV
 TdmrmXqaJqz2qPTYnByl5tYfvzLijF8axWbk83GMckDeihEyaA2hFc43XvUAXYyhYP1zwVX9czv
 n7oDvJOUbs35AsTreA9j5qS83juNz+ZYkQvEsgeUdoOG4v3F5XNqXeNu1oEzcuh6re3dFWnBMyv
 PCKaKC9wK2Odmip+wgEbPws5zLHLwk91mD5Xl9ubf0EDf4E3xQ1m9Wj73OQ7eO1K1a9GuOo+ylI
 yyz8fTesa5RaFerEX2K8ek939OO9oHjoo=
X-Received: by 2002:a05:7300:ce03:b0:36e:c9e5:33aa with SMTP id
 5a478bee46e88-3751fb32275mr2389935eec.13.1794300681906; Tue, 10 Nov 2026
 00:51:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <e4322cc3-01a8-4a91-a0f7-fbcf0807a375@gmail.com>
In-Reply-To: <e4322cc3-01a8-4a91-a0f7-fbcf0807a375@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Nov 2026 10:51:10 +0200
X-Gm-Features: AclHuK_CMGh7LVeHF8gslEzrt_n6pswtDFJPlkUlGIlNs3ZjvEbLTyJKwZpRfQs
Message-ID: <CAPVz0n1V_6ajUO4BfKGC--OAeT+qxjNZr+xFKTzk77hW46x_bw@mail.gmail.com>
Subject: Re: [PATCH 11/11] video: tegra124: dp: Limit the lane count to four
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding <treding@nvidia.com>, 
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:30=
 Ana Bobillo <anabobillo3@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> tegra_dc_dp_init_max_link_cfg() takes the lane count from the sink's
> MAX_LANE_COUNT DPCD register, masked to 5 bits, and link training uses
> it to fill the four-entry pe[], vs[] and pc[] arrays on the stack. A
> sink reporting more than four lanes makes tegra_dp_lt_adjust() write
> past them.
>
> Limit the lane count to the four lanes the SOR has.
>
> Fixes: 59dd5aa8fa51 ("tegra: video: Add Embedded DisplayPort driver")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  drivers/video/tegra/tegra124/dp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/tegra/tegra124/dp.c b/drivers/video/tegra/tegr=
a124/dp.c
> index 611bf2f81a6..22e9a4b15f7 100644
> --- a/drivers/video/tegra/tegra124/dp.c
> +++ b/drivers/video/tegra/tegra124/dp.c
> @@ -664,6 +664,9 @@ static int tegra_dc_dp_init_max_link_cfg(
>         if (ret)
>                 return ret;
>         link_cfg->max_lane_count =3D dpcd_data & DP_MAX_LANE_COUNT_MASK;
> +       /* The sink may report more lanes than the SOR has */
> +       if (link_cfg->max_lane_count > DP_MAX_LANE_COUNT_LANE_4)
> +               link_cfg->max_lane_count =3D DP_MAX_LANE_COUNT_LANE_4;
>         link_cfg->tps3_supported =3D (dpcd_data &
>                         DP_MAX_LANE_COUNT_TPS3_SUPPORTED_YES) ? 1 : 0;
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
