Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31050606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bOsRkXqW;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iaB/1hcy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09520608A1;
	Tue, 20 Oct 2026 07:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3U8kwgj4LH-n; Tue, 20 Oct 2026 07:56:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F2F4607FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483002;
	b=tMb2aQGxiQYkfinLWZzYQbtFPKWGpQepazgpQ3jyQv3tZXLVWcaXRu4YE9lQA1mTnCo4
	 IzcBOvhhjM9C9trE1U0G5nRA0fHP6LG9U0YqpHew0WeThDNuoBK3ekW4IMLTmGETfmcmr
	 V/Cw4dzpIi6/Saf2c6DYVH+hztjP+p+Qxh3HwSg2OPmULvrEYQcdh3oRVqrzY9tZtJGIU
	 C34XbclmGrW31XCc4WCrLOgCDhScNQk2XTMGhAUQIoGdNwuj8MAbtfBL7Zhj1ONpeJMyP
	 q7/G3nPa08bEG/8ECgjLTY8KJXS+GrQC90II2LgoH3+M4SGxm8tEZjBVHD6lHy9wbDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x3TW0LrU2YpqbAojxEP6vzA1Pjbl+ZNrCAYMLhUkFDo=;
	b=p6zChUT4+Ly1YuMaoHUVBhDrrNMNlQ8nDvNubAo0eR7AyQ4z5LsIVmptMzMU+qFpH2lU
	 riVxQ5OHnSk30PjU/Jic5AzL4mXtljgP3PByWb+DePEaDoRZbcsD+ho267wIa6Z4DgJOr
	 OrWxJbth9JNz0UY2BBPVWDIVaTYPTYKUAEyb/hr6jcy5SZAs3/fbtjX6KZoLKhxCDlnPO
	 wdJX9HawBOtwY8SXM090coexce67PvcYg/cMcfgmPP+huffujYIynkDSrokM1xcIbq2nK
	 yIM6f2pFWdaRx7HJC3E+6l/u/v32B7qWLVXJ06edMLolzln3zx+RkZEOBWPihyg/d0w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483002;
	bh=x3TW0LrU2YpqbAojxEP6vzA1Pjbl+ZNrCAYMLhUkFDo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bOsRkXqWQ+cIKFKRZOSYQIrmcdxnUDRzQBHmOR1dRLECN+7Cs4y3TDq+twmVAolPD
	 CgdGjO+HQUIF3kWONxMActTzkamyEmUsEgh2gq7+h+oCw/FiPuuHonRNfWqBUAjouV
	 i7GCw9zV1foZJj8jTwPuRSqouHJoG77LWOs4YYRWWvsim74FSuSdklRVfWZUpwJr/m
	 oNAk7ls4Z1CEECKRDAwC+uxbV0ZKocxmIKaCGKydRak+uJdi0YSKFa34+au/IskUVi
	 h7sNQeP3t8VzsTrTEmcDrlybZPZJsnzjyH/02J5nRf5UXPcTS6SoFzwiK+Ac76FtMP
	 ddtJ1m0Jf6/QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F2F4607FA;
	Tue, 20 Oct 2026 07:56:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE81E279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE5314081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M73S9uLsKo6a for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 271FE4080F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483000;
 b=YWMqebQviWzKvtyAbA1HxOAlatokjGjenK2yWvENjaJwZD6Oqu6LxXE0hLjf52DypNg3
 pJEWfubki843c3fo9yEPmMQdxmVjiMntRnLEY2TmJq/BtAajgcVFl1v2Wy2vacKswIwLh
 7sF5Mi/IBUG7onTph8RKiEKbX8XrMNJRSKX8MmaUKyUVbJMITqCxuwdm/5xQRENIuB9pk
 LaksMTeTQg6ZrsLUjHCQWmzeD2mSuNKBYIndMybU4uVA7uhrJeu3ui03CWyXKp+v/osfC
 hs4jwBMipgbiriIqeAN31+h2h475HgpWIayf1vT8Nfm6O9p5/UbfZxj/qhHVdfV1GcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483000;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=x3TW0LrU2YpqbAojxEP6vzA1Pjbl+ZNrCAYMLhUkFDo=;
 b=PY2j9HwpzEIxVCZmH5aV+56swZMmckZLWBx77EzTfn0QcB7o1Y3g7IR8l4J0FEJ4dcvu
 sAxe6AjVUkb6bpSbs7skaiUVFoM3+eT5st52TUUcX0xPV2Xd253OMMaIRA6O0E/P1N3hL
 ooa/IsROj4MmgtpiWf2xDdDgQWd4i6YWpPn6YqJWXbK79gT1ieVjkRMJJdDcMZWKaQ5gr
 Ma2zf2WC6SSTrVz9QUCraeqef8bfrWTtw2sw+xLWu/iNmeNW9ZmVSkucY4M1HxKYF7uZC
 y3UlgR0GDT34NDBcB28vVq4evm+CNcLhnVvhObna5t/liZ0Vy4qg/COwieFsX/WrWiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="iaB/1hcy"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=iaB/1hcy
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 271FE4080F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:39 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e942864693so13185465ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482999; cv=none;
 d=google.com; s=arc-20260327;
 b=WLXZ0A9n3RMdsGnsEt5aUj1n8f1tALA2/+ddsTaRiAS9b2Mj98RfEMIb5v+mPoBMgk
 9gGPPqo2/afzyH7YROzZkFx/ae/5ka4eqCMo0ng3fwaoyuQZ18mjxn0gUOiXQhXXlbyO
 815nx6bwOzObAfa1bnawqJFX3p+rWNxy2ckykW/p5nQYHGpitVARYzuoz9k8VnlNibHZ
 D1LEKAEzOfweQ2kbsod89ZtckcTy6G9bqo8PxLphR/6oI/G0T6oxvxUvtoP2XPkUF9/Z
 Kl8COw85cjFoFkUyb0ql2QN2fey6U78BwNwfqNat6rMwX8mJAg8azembv6vajfvFtTaC
 5dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=x3TW0LrU2YpqbAojxEP6vzA1Pjbl+ZNrCAYMLhUkFDo=;
 fh=27gbidC+2zcfW13xDgCp9jrrMHyur4POYfBXKCFdCZ4=;
 b=n2x7tpjccDfGHGFOPcuFSc34BzYmDmgLAFzymnuRQmwsGlpo3n2z3cgyri//4krrEY
 WiIcdqownhnYB4u65NKNikjB9PX3DBpvunjL9uyoMHbTE7qVR7F04YWEkRZWk7Luwmri
 dvzMjFHavm9kezgHVtYjl3QQEmVXNTgrg1jPB99qfSo5btIFR7vpH3f3xN8sfdZXTPTY
 o5AJkcHFtXsqAj4s9NCITlOfvOVqEbzycBw+1VHBzVQMmI2RSCQ1Pq/n0EzNE3abTw6j
 TiqwIFV+/peLpjW4x15y8kdOmZw84MbigSpPAizYiN4VM3QxG4lML8KWRLI6EU6YgG/T
 uhuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482999; x=1793087799;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x3TW0LrU2YpqbAojxEP6vzA1Pjbl+ZNrCAYMLhUkFDo=;
 b=iaB/1hcyk9vTCN3pRaSPPsDUmwHVuYtKetdklBo5D9rGlzUj4B/mK0/y7e6XoBN4oT
 nZ3iWP+rOG1k4Gi0h7MW9a14/IdieaHEspvoWHkxKkpG4KZx0NbVM9/UuHEdSBac2odl
 7bMxVMfh63LGRqdeVhP9hbeZVcvlP3a26bhHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482999; x=1793087799;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x3TW0LrU2YpqbAojxEP6vzA1Pjbl+ZNrCAYMLhUkFDo=;
 b=vSy8D9jPwWbTdbheGhfGn6UI5Z+1RdofY9XKcwgxQc16I6xX14bqGjQgnkaj/zaok+
 aDNpIzwcmUaj3x8V1jn68pX+hUFWiz39Tacrj2Qyz0a7Hzlv1O+aATDR5Usp2Q+Te+XV
 d0epRskqLe5XmgKCp2Qwz8hUT3zxkPePJh3qUhP8v+CEyInuFgzNEa2ZpRcu5KguKZ3U
 wSGgkSPJC+3zkx+KB836YXpJLJqFonwLVIM6Fo0esd+t1W0Lb76AcrrBLYATR5GOknl9
 yLXKD5DU3OKVgM+Q2g+1X+j+K1IANjUVKVXtMfVTyl+xVcXS2CrJ2bthHvESuFhUNFtN
 AVig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXxWJrtut8WtoMfyEebSgqtCuuGRfqbhbvO+pTql0RoGzQrq6xvCdD+LD65RWk9RhXKbtTOPk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLCUx4VyyVnd7UDEuikekpjnTNlAl+wur5x1F9UasIm71NTX+cs
 GG5NuU4a5hcdJjAJXpfbMuTZosTkpMMw0esGaNQScu/7PZpUYL7em9KIGsu9L6/e/7fkNrMRjdC
 KCxeBfQJ1gZQuwnNCMGn+3AS/toO8WdjPrVT45Zxo
X-Gm-Gg: AYBFou1rnR1gzsqdbjwX6IwWYUuHVNDSo5Cez51/8Zu5ZNRLSdQ4zU5zwN1GfBfqIAf
 JycIjVHOBH2keJEsoEp+f2jM8tMyv2gBoh/WdRdZP1/Ll1etXNjy88U099sKNkdWBWBia9ifBWy
 dJqo6H1u4M+hiB2BykJyHoTj1jWBrKH9XaM+lHuiR8IGlnB3Jos9F6RRjMSviT9iSyPxxyJXr4Q
 abPM5DHKX+iOBtnibc//v1Y5CGC4P/3hiQqRrJmaQN0kgovUkFwBobUovjCT/dJugUOtPaDFY37
 GqPzjrehj8ToVScTqzj1qBKqJ1NBOz071bYXvorH74306f9YVqK51g==
X-Received: by 2002:a17:90b:48c2:b0:3aa:6b5d:a018 with SMTP id
 98e67ed59e1d1-3acef57d165mr8338338a91.67.1792482999129; Tue, 20 Oct 2026
 00:56:39 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 02:56:32 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:58 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <13d5094ef59c11f53b32a2f6184ec50258c5f79f.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <13d5094ef59c11f53b32a2f6184ec50258c5f79f.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 02:56:32 -0500
X-Gm-Features: AclHuK-ybzS78TpLiJVbky6REd9eVbNvr9VPl0qX5sZtSo55GSKrpI9CGsWTu9w
Message-ID: <CAFLszTiYY6UGoXsGvc9ttX+7ESjGabU5pb6fPvP49g8Rs=anUQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] boot: imagemap: name the device after its partition
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: imagemap: name the device after its partition
>
> imagemap_create() names every device it binds by index "imagemap", so
> two mappings taken on one block device appear as two identically named
> children and the device tree does not say which partition each covers.
> The name also comes straight from the caller, whose string has to outlive
> the device for the driver-model pointer to stay valid.
>
> Derive the name from the partition, by name where one was given and by
> index otherwise, and hand driver model an allocated copy it releases on
> unbind.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/imagemap.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -441,6 +442,8 @@ int imagemap_create(struct udevice *dev, const char *name,
> +	/*
> +	 * Name the device after the partition it covers, so that two mappings
> +	 * on one block device stay distinct in the device tree.
> +	 */
> +	if (name && *name)
> +		snprintf(buf, sizeof(buf), "%s", name);
> +	else
> +		snprintf(buf, sizeof(buf), "imagemap%d", part);
> +
> +	/* device_bind_driver() keeps the pointer, so hand it one DM can own */
> +	devname = strdup(buf);

The snprintf('%s', name) is a double copy and silently truncates
caller names at 31 chars, which the original pass-through did not.
Please use strdup(name) directly on the name path and keep buf only
for the 'imagemap%d' branch.

Reviewed-by: Simon Glass <sjg@chromium.org>
