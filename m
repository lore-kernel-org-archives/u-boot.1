Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68C7CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BC0E809BE;
	Mon,  5 Oct 2026 11:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a012eWCKRjCv; Mon,  5 Oct 2026 11:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2CD8E80980
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791201368;
	b=Jh0GGaVHTBoOhBOcZXLqPQfYI9O6SUmlRD2harXtKtylOiJ8HGk3+bEcn62RZXiuxfK9
	 REEsIF+d4tPJT2sw62dKkPP7ykg8VQat8popqZDf4CgENdGOIsst/16hB2xLKGyz1oeNw
	 rdMcjrwUP+j7xIMqpymofG/h3p6taFYURaNIExfWC0FQitltXld6wlsXeW6447RXabpkn
	 WLDYh7UHnsxA2Yi0gCFX55xuWvvH/MM5AUegjwC7CUIgpEPbnUJIquxmTmB5u4TsZJoEg
	 gNBaEDoonpKRJeNfy3HsJ/kN7cMWeYWKw0o3QctcF+jPssa4UGBxE+qKpZ8PgJ56XXg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791201368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5w8gCNORFHGICyNS1rrvGC1oxVcbEXa8vp8wQ+UAhPo=;
	b=ZJqjBlAQXsxPpwJTlQgaBPPV1fzDr9mV2ZOC5oLQyga/A1Sp1hNjaj3Ui1ZUKHblMmgw
	 i0iaoX2mKnBYL0xHVSIwtq6+WzPy/PPYFlXWxFrFmykCQnur9CYlYaU+aUVROJmLQTFyo
	 orcsdn1uBUmXnmoEhou7y07qNnEzn8E0gMDcGXUA5dkivXj69sRQ8S0hF34/uORomWbGO
	 kVNvu/oaZWLQFkPSWY0Cy/6UGXVaZSDDAH0pGVa73ogPy8A5cPBZ7lOGwmCIovuTgAUaf
	 Pgi9mqT3vWi3wGHrtnJNTafZwdfa6MfaC2B7tXYmHvEymAqNFr1wvoMSsKs7OVVZjgw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cJsxBoYE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791201368;
	bh=5w8gCNORFHGICyNS1rrvGC1oxVcbEXa8vp8wQ+UAhPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B5CdBaTrSo/6rbjbU0zv8zroJKtx4HlSDf3b7W7rI0AVesKQt9meFUzVXPSLJuqov
	 x/ZmgJRUZ7IDQYfJLLilwM5LnPlserdSEtQfG1/gPhqWrhQQN5mjZHkJfjJJMw1Jzl
	 GdojpBH/agJ9cb1KXqyyXvjeNPOdo5unucVmGdL0nQ+h0ssRxJUNo49InA3vq1NNt4
	 W6Sp1oE7N55Sfhv2qWL6VPbKaWqjn8Dk8d4Dd/vY4ilTo2y1pdxpoTvCyAvJ3o05w2
	 qrCUq3P1w5KR9Mh7sXZn2mDKFkSKPdHqH7n0XxWH/29mj5T09sYTGpl+3FNoevTn6U
	 xJszYP8R6mTdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CD8E80980;
	Mon,  5 Oct 2026 11:56:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63C8934E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54EDA80963
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KEHgG784gVRz for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:51:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10376808C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791201113;
 b=JfdcjZsgtElDh/04WIJg4PxdXZEpEztDzxlewPKJFz5k0g4ZGwdPxkRE0+nkVNrwNTNi
 mjl1odlTOHKY8rH+/BVwUCGr+aswLLDRSN5yZLLhjTk0wbOrhbW0G0AupIarUVUol1MC7
 Z3B6qK0Jrg235PolByRmZ0x2jc/8o9Am/lsHmlEf2MBVCrYaHw9HTIIz0cZQBvSomVt8r
 LrTgZ3KoAd1ithGd42XgNFKD1KjKKBZTirzXzIazWys1dqHe88kYim5Z2+HTFbApK9Koj
 PVq2U7WeM8938TRzg6948jQ7a06AiO4C2ciUETyJ9G9DYH8Itrm7uuv9GSQmrEQRxdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791201113;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=5w8gCNORFHGICyNS1rrvGC1oxVcbEXa8vp8wQ+UAhPo=;
 b=TIW8f7AH5clL0JF3B+tEak3DHlVsFxLYAONAOfWL/iuDwqRyVSxdDXeuqMuPgrcW0Ps/
 7Fib52WpB9VgLIPc/NQuIem9EmG6kUW3dP2lBn+ItBM1NXE5nfWf4MeDAhujlsNlAFKxC
 nx/yPE+9Wh2a6jzRCL5wfZfzeZUlovXwd4VPtJJ5v3NeNc8UuLinMIWgAK1zvC5ZGew/S
 8frq0Plu649jNmdKEsgXpc0h2bQNuIACzaXZoe+J/3qFRno1Xh00Npo/norEdLh9lk4a9
 gFDiGu/Bb/+KR/c27iI1Im7I1a6rNDEv/GAQkEWQuwfT+bGQO584TRUdDFttoVs/OWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cJsxBoYE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cJsxBoYE
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10376808C5
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:51:52 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8871ada1a26so10948427b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 04:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791201111; cv=none;
 d=google.com; s=arc-20260327;
 b=DqLgNL8Io5dSNS9+G8dYgBkxmDKCRqm3XAVNwbEsClW0UWrYwvqRnk8qcx59ANAlSM
 7hKqc/CzdrU2Oj2/TuFfwK2jpzUg3vwPQqPAlWpstQItf2tyPXr+TkZ53mWXSIDWK4St
 4etZua8fMK/Bh+vGmHbxyKf9qQ1mr1SjZrLyJ0kwFyWPzY+ey+gU6/uP6q3tcV9PlCi7
 x4yJqaR9JmnTo7QM+vU7huoEyr4PTr+7g5gz70ctYSfIXwddQYkAzOTYwB8L5EqBtUQE
 HhLT5LuQKVVyFqHcMJmg+wUquMM/TCNAkl3156IBimSLpTprxtvFxrW3HVVuZ6VKF9TW
 m80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5w8gCNORFHGICyNS1rrvGC1oxVcbEXa8vp8wQ+UAhPo=;
 fh=dBPtYC1TZ/qisQKccqrPk+ZU1k6U81Ut+AAudAfs85g=;
 b=A+tRY2z22121b+eSrWnIWh52h1r7m7DAZg8vbnbwjzeQxV1owjKWUmildtPrYM+zCJ
 S+J0fr+S4bcG5G0kSM+QDLDT4Hjvsa9z0xZfZs3Jd6Km6Xu4gt2bUzgmjkxH9SPlU+JA
 ylDnSO8P+CWeht6Jkp1RTsu0Jda8jxE54UgqjA/UJcpfZuCPVgNxh2Cw2YhqHYs8OiYr
 4SEPAfbmB1jjoWndio+dqEpk3sJo1ziYKZq8n7jF1WAnX8npoXf/6y/NxRZy3VeRf+uk
 uKhTJpJ4bN3D/gHvrO3toN7ewke5+jNdo+eqHhMgpTPttshHORKvbp8JXYlxfcrSt9jv
 QJgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791201111; x=1791805911;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5w8gCNORFHGICyNS1rrvGC1oxVcbEXa8vp8wQ+UAhPo=;
 b=cJsxBoYE61TfCPkDzJwfwLKhwMvOckQS2l7yG9dXA1Nx5XlNfJX+iJtyZM6u0rcH/Y
 YrMMVWJxE2uE1m6W+wBjofoXBUr8fGRrDIxG/+0tio8HPLXvWgVFYlHal5RCPqCycIum
 vq6PBxIovevr19T2mN63EQ+UyKIt6HOs8PrSdRNBOW3oMctzONtsrbUhNvLjUMyYBFY2
 xOiCB5LEtcZhJ/K6u2Bx84SmYpVNJz8FQHXwSND/gbPThMipXZW4DhS29N8Y20CKia0S
 nvB5IwwXmFzgO0ljFYqEhISzGvN5/+PKhuHFeXXp0D/mkMfiDNk0W0noDzwyoBzRHCpi
 5m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791201111; x=1791805911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5w8gCNORFHGICyNS1rrvGC1oxVcbEXa8vp8wQ+UAhPo=;
 b=e4k2ZYKieoTjHKIMYhfVdo9NXZlZ29FyTxm66K1PC2gYx0AJYTxWqWNmeKIrVN6K9H
 2BNp/SfGLsZLt3S1xK4c1ahBqUEQlPvuhX7rhITjLYpgQMFOo2Z/kU+6FRTPGwNp2KbF
 90PTD6TVl8XhjW3KPzJWUSd2mlsD/3K8JNLuZeQqmKAzzyDO/uKfCr4yqXXKaZsrYWfx
 N2r1efJBonSpGCjRrLKxB/JR/EobPJEUTjx9BFPcy3SCozYm+VnjZ1hQe2FMJx1419Nr
 Pz6sBlvBNWepuvN5Vyu4GagYucGn8AsX5Gzmw2+abeskQe3lGiyMbHenr2z0OTKO7CEJ
 N2fg==
X-Gm-Message-State: AFq9FYJpDycxnSK/m+siJnzKXKVDsZ/fJ/W4ZEPZCtbxakFyO3C39ued
 lKfZbssKxyJel4lmfPtMdFdmMMZv3Pm5y730WY/bGT4DzMzT/sgbumoQH08e/0HLUlvliby6lAS
 YBTYNdPoqGanXedSt4IEgmYgG+mii8jtCk6PXJ1MErg==
X-Gm-Gg: AYBFou1sdjBbwWq8Jw0RGdGbx+qVZInQsLJt5BuyAubEXxR3LgjVE/wtOaf4aVw817O
 k2IiAInmlMahY1KCCpbJSbLNsCo9XeTrGeCEXe70GNnqSZ1i3E4JwvqA5YQqTbShyVxVb9YafpB
 Pay47xZsu++zThD5dsa2yfnDVuNqMV/gkEApXF1fe7awUoIN/ewIMU8OsAIgskhXFOIERZ1nR7/
 9qzqMpFO3fNiqABuDnotdi11ZA84Utw3CG7Y5YZKqXQ5wWJMSaf+GjrUbSaK7u3xQQnduIOllOt
 APwvEhIi4M6+sdgvviCMxXSdgcYzTvwo2wdn+b2vAGPX5FQQKqpwt4KQpQe9GKSht1LvaFQ/Ze5
 YTGLatfwsI9vl11t/AMWGb/+5FfksoRwb05ms3oRYFkK1pYlrQQcr+Gj4TPSwQhvyXVpNBaIEdp
 l/w//OizvLCICOJd6wTiJzwoanPO17TaPXQ7CyEZTeJC/ZAd9MRHupO3ROWr/RYP5USw+/IbNAo
 HXchfKlG9es08CR7z4fK1SqOf2lcHTnck+Rv1e68G2TGkuyoFvPmgb+ouYz0OGpbC5E2W2+Fnkv
 mA5x8mEVOhH/RjWpKOfR0S7nM4EZH0ieKg2OsWGCkDGIfXpeiHRsG0izDluHiNLi41XkzUzxrir
 RH+yPgHXV4G1BwSpoMd4fKCg8PrrFzKY6EGfA2IFF5aFvOrnM8JbD2po=
X-Received: by 2002:a05:690c:e691:20b0:8aa:17ba:166d with SMTP id
 00721157ae682-8ae951f36b4mr16434927b3.81.1791201111131; Mon, 05 Oct 2026
 04:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-13-harsimransingh.tungal@arm.com>
 <DLINN5K2BHFZ.19HZZJ3K3T9VR@linaro.org>
 <bd9d4332-f1e7-4c66-8524-2dbee628a364@arm.com>
In-Reply-To: <bd9d4332-f1e7-4c66-8524-2dbee628a364@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 5 Oct 2026 14:51:15 +0300
X-Gm-Features: AclHuK_04lUV7nRuegq1tmZgoG_tXl_7FxiXk6uHtH_-_bSM4B5sBS1mOtkj7Lk
Message-ID: <CAC_iWjL4kpiSu==ukqz-bCdNoj9J9E=Nnax23sZJeLHTzRGjAw@mail.gmail.com>
Subject: Re: [PATCH v5 12/22] efi_loader: reserve FF-A shared buffer for
 runtime variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>
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

On Mon, 5 Oct 2026 at 14:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
>
>
> On 18/09/2026 19:30, Ilias Apalodimas wrote:
> > Hi Harsimran
> >
> >>
> >>  /**
> >> - * setup_mm_hdr() - Allocate a buffer for StandAloneMM and initialize=
 the
> >> - *                  header data.
> >> + * get_comm_buf() - Obtain a communication buffer for MM/FF-A exchang=
e
> >> + * @payload_size: size of the payload that will be appended to the
> >> + *                MM communication header
> >> + *
> >> + * This helper returns a buffer suitable for constructing an
> >> + * EFI_MM_COMMUNICATE message. During the boot phase a new buffer is
> >> + * dynamically allocated. After ExitBootServices(), dynamic
> >> + * allocation is no longer permitted, and all runtime communication m=
ust
> >> + * use the statically reserved FF-A shared buffer.
> >> + *
> >> + * The caller owns the returned buffer only during the boot phase and
> >> + * must release it with free(). During the runtime phase, the returne=
d
> >> + * pointer aliases the static FF-A shared buffer and must not be free=
d.
> >> + *
> >> + * Return:
> >> + *   Pointer to a valid communication buffer on success.
> >> + *   NULL if no suitable communication buffer is available.
> >> + */
> >> +static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
> >> +{
> >> +    efi_uintn_t comm_buf_size;
> >> +    u8 *comm_buf;
> >> +
> >> +    comm_buf_size =3D MM_COMMUNICATE_HEADER_SIZE +
> >> +                    MM_VARIABLE_COMMUNICATE_SIZE +
> >> +                    payload_size;
> >> +
> >> +    /*
> >> +     * After ExitBootServices(), dynamic allocation is no longer perm=
itted.
> >> +     * Use the predefined FF-A shared buffer at runtime; otherwise al=
locate
> >> +     * a fresh buffer during the boot phase.
> >> +     */
> >> +    if (efi_at_runtime()) {
> >> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
> >> +            if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> >> +                    if (comm_buf_size > CONFIG_FFA_SHARED_MM_BUF_SIZE=
)
> >> +                            return NULL;
> >> +                    comm_buf =3D ffa_shared_buf;
> >> +                    if (!comm_buf)
> >> +                            return NULL;
> >> +                    efi_memset_runtime(comm_buf, 0, comm_buf_size);
> >> +            } else {
> >> +                    return NULL;
> >
> > This is problematic for the existing use case. With  the changes in the=
 later patches
> > that swap all runtime call unconditionally every call to setup_mm_hdr()=
 will return
> > EFI_OUT_OF_RESOURCES and none of the runtime services will work without=
 FF-A.
> > There's nothing elegant we can do about this .We either Let the fucntio=
ns from efi_var_common.c
> > deal with the runtime part (which I think I prefer), or we define a sim=
ilar runtime
> > available buffer for comm_buf.
> >
> Thanks Ilias.
>
> Yes, I agree this would break the existing non-FF-A runtime path once
> the later patches install the TEE runtime handlers unconditionally.
>
> I am planning to keep the existing efi_var_common.c runtime handlers for
> the non-FF-A case, and only replace the runtime service table with the
> TEE/FF-A runtime handlers when CONFIG_ARM_FFA_RT_MODE is enabled. That
> keeps the existing OP-TEE behaviour unchanged, while the FF-A runtime
> transport continues to use the static shared buffer after
> ExitBootServices().
>
> Does that approach make sense to you?
>

Yes it does

Thanks
/Ilias
> Regards
> Harsimran Singh Tungal>> +              }
> >> +#else
> >> +            return NULL;
> >> +#endif
> >> +    } else {
> >> +            comm_buf =3D calloc(1, comm_buf_size);
> >> +            if (!comm_buf)
> >> +                    return NULL;
> >> +    }
> >> +    return comm_buf;
> >> +}
> >> +
> >> +/**
> >> +static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payloa=
d_size,
> >> +                                  efi_uintn_t func, efi_status_t *ret=
)
> >>  {
> >> -    const efi_guid_t mm_var_guid =3D EFI_MM_VARIABLE_GUID;
> >> +    static const __efi_runtime_rodata efi_guid_t mm_var_guid =3D
> >> +            EFI_MM_VARIABLE_GUID;
> >>      struct efi_mm_communicate_header *mm_hdr;
> >>      struct smm_variable_communicate_header *var_hdr;
> >>      u8 *comm_buf;
> >> @@ -555,16 +615,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t=
 payload_size,
> >>              return NULL;
> >>      }
> >>
> >> -    comm_buf =3D calloc(1, MM_COMMUNICATE_HEADER_SIZE +
> >> -                      MM_VARIABLE_COMMUNICATE_SIZE +
> >> -                      payload_size);
> >> +    comm_buf =3D get_comm_buf(payload_size);
> >>      if (!comm_buf) {
> >>              *ret =3D EFI_OUT_OF_RESOURCES;
> >>              return NULL;
> >>      }
> >>
> >>      mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
> >> -    guidcpy(&mm_hdr->header_guid, &mm_var_guid);
> >> +    efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid,
> >> +                       sizeof(mm_hdr->header_guid));
> >>      mm_hdr->message_len =3D MM_VARIABLE_COMMUNICATE_SIZE + payload_si=
ze;
> >>
> >>      var_hdr =3D (struct smm_variable_communicate_header *)mm_hdr->dat=
a;
> >> @@ -1077,6 +1136,20 @@ void efi_variables_boot_exit_notify(void)
> >>      ebs_called =3D true;
> >>  }
> >>
> >> +/**
> >> + * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap=
 callback
> >> + *
> >> + * @event:  callback event
> >> + * @context:        callback context
> >> + */
> >> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA=
_RT_MODE)
> >> +static void EFIAPI __efi_runtime
> >> +ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, vo=
id *context)
> >> +{
> >> +    efi_convert_pointer(0, (void **)&ffa_shared_buf);
> >> +}
> >> +#endif
> >> +
> >>  /**
> >>   * efi_init_variables() - initialize variable services
> >>   *
> >> @@ -1085,6 +1158,9 @@ void efi_variables_boot_exit_notify(void)
> >>  efi_status_t efi_init_variables(void)
> >>  {
> >>      efi_status_t ret;
> >> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA=
_RT_MODE)
> >> +    struct efi_event *event;
> >> +#endif
> >>
> >>      /* Create a cached copy of the variables that will be enabled on =
ExitBootServices() */
> >>      ret =3D efi_var_mem_init();
> >> @@ -1103,5 +1179,37 @@ efi_status_t efi_init_variables(void)
> >>      if (ret !=3D EFI_SUCCESS)
> >>              return ret;
> >>
> >> +#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA=
_RT_MODE)
> >> +    if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> >> +            /*
> >> +             * The FF-A shared buffer is accessed by EFI runtime serv=
ices, so
> >> +             * keep the resident pointer convertible across
> >> +             * SetVirtualAddressMap() and mark the region as runtime =
memory.
> >> +             *
> >> +             * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-pa=
ge aligned.
> >> +             */
> >> +            BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR & EFI_PAGE_MAS=
K);
> >> +            ffa_shared_buf =3D (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
> >> +            ret =3D efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANG=
E,
> >> +                                   TPL_CALLBACK,
> >> +                                   ffa_shared_buf_notify_virtual_addr=
ess_map,
> >> +                                   NULL, NULL, &event);
> >> +            if (ret !=3D EFI_SUCCESS)
> >> +                    return ret;
> >> +            ret =3D efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
> >> +                                     CONFIG_FFA_SHARED_MM_BUF_SIZE,
> >> +                                     EFI_RUNTIME_SERVICES_DATA);
> >> +            if (ret !=3D EFI_SUCCESS) {
> >> +                    efi_close_event(event);
> >> +                    log_err("EFI: failed to add FF-A shared buffer to=
 runtime map (%lu)\n",
> >> +                            ret);
> >> +                    return ret;
> >> +            }
> >> +            log_info("EFI: FF-A shared buffer runtime map: addr=3D0x%=
lx size=3D0x%lx\n",
> >> +                     (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
> >> +                     (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
> >> +    }
> >> +#endif
> >> +
> >>      return EFI_SUCCESS;
> >>  }
> >
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
