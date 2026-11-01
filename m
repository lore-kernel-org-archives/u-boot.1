Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA107606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PhdfypU1;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eASsiL0X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2C1A405ED;
	Sun,  1 Nov 2026 15:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZj6O-1P4dxY; Sun,  1 Nov 2026 15:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD4F6405F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793545278;
	b=bsgTK4nDlbaI2Ss3EbrmMEtLSWgEBzgTWbZeg0vWNkqI9xy//VjLWFe++IW9fURuIpeK
	 wkEGheeLKVd9gev5PO/NIyh3HzcBwyk26ldNlkDx0lUWZuwx7EcWtDU3juWL97q+g9RFn
	 J7KieZobTuJ+REvJG3Kd+91wZNUPPYHyB5eqfQy9v/vow3s+kKNuEKTj+RuD+V4E3kxbl
	 LB7oWZ9HzgY3VJN4sathmd0+BCykseQG+69F1uhXeWo1hIjfmDuV4BzCu7ZSdFuRLoIYS
	 WlVg4OZRJpsmZ3ztCAGFrKZscJIONU14FvNr9a0GDg9UgH9DVT+F+5T7f/J7HG9jzcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793545278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IogoNDXSeGX8gCD2Ni51aCnvJEmys7wKaklf21/n+gA=;
	b=UKkPEF+sI+ZW0K7YQwmyi4dy9QfCG1IkEXYEVcwBl1/jb26uEcLuK0um/XV3n2XXyxfI
	 ojVCJyFpOrYAf8+zvAtviOErYuutVMbYXb/i2C6SHNFhTBlYL3krr0AQYhBY+tF/ljfT/
	 27TBVt9WyVgY+1x0nwwYmftK8zhFhQqtL4Ts3D6iXlfftxlAU5qoXvFZc5lGfEkGW0/a0
	 hZgtdpBI+782TeEdG7O5AP+LpnZky2SoVKp+H7OZWHWEBQk7IQ0n/RWyXmt8pOZWg5sP7
	 lztvyIsNNH7cZs/bDrDs0ZrdTMVyJD337h7sbec38RJ2RFgGG1Ttp1x/9SJsquTIRKg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793545278;
	bh=IogoNDXSeGX8gCD2Ni51aCnvJEmys7wKaklf21/n+gA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhdfypU1Xez+7Kzp3vQGbHul+r1EC0Vd4JqWa9kRmSpwf3HoJVKR9krWIWz9hDr3W
	 zJWmMX79rGg4dk1K930vWfiziDB+tfL16ALart7evUs2W1TjE4k019QEhu7JCFvj1I
	 l//4XPQP9uKC+M6ZNcH4L7EekrnW8GN1wdmtQYUvFt636WqL15oof2V2NgWQGkwjUD
	 8gDDOEnyHKAUamQb7PgpIe35Vk1sHZszjejrp3K5gZGgIOvX99EilPohobyVDo2f+p
	 lYD74vk1D7aI4Zt11HPQnGqDnnod+hY0ukbypubih7pInhQ8uVVtgxYrxd9ZVKDKx5
	 P/2n134bluahA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD4F6405F5;
	Sun,  1 Nov 2026 15:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 393E0323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B1C94009B
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3gGKPeEu7Zf for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 15:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F40664004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793545275;
 b=R0ad1Pm42a+Vyt2GaxBH4P8S9lMOHE10oCPN+sbW5OAKXQT0OvLCaokwUTp6oM0pmB7+
 NzoKivaN1yj834NNzbsPyFiSiWZ8ES2wDYJZNHBNv3Bwe+fciOMBy7zhRltrtG/6yPhDa
 Rj7aLQlTOik+feJTsOLiwY2KU1sWPvb3mCOSpGcMApEKoAagLT9XpPI4N71aUG91s+l1L
 fOx1OaeNsUHVQB7Qg2d/ykKGo0XSvynjav5Ai4Yh6ZwQ0O9jaVRBJjw6xGnpUuS0Xh2kT
 XfgYPySo4oOkJ6IlvRZTt7/4YbVzaTD4iXw9k5wUg8jpRA16UA0S3k5omkFwi8astpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793545275;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=IogoNDXSeGX8gCD2Ni51aCnvJEmys7wKaklf21/n+gA=;
 b=isc6EGNaCEEDpRIxit9O6U8ly1IIP2x0AZeuBvGBe+7izYrF2C0vbq+CdnPZBt6S4b/U
 oKgcpqwx1PBH/7OGaHpBgRtSbr4TtVRy2v8ARTwg4yCqQUjTxSgw5VB+jrhWzfG0PLY5c
 El7MTFo/CZMnsnmcRBCEAMGmfFRQiWNDti0sgTHYVlyHajiI/+8rhKivXe85G0pkp7CjY
 qQI3gtMCe95yt4BPf8UjybLkS1nEGWAOq6KWHMlYneQIRmafM2XfNBb/Sycsw/6IjNyK6
 1mQHIN9aQK1R8SrL1f3T0VxDJLEZ+URlkjvKGGRvrfBpCggpnPXVTUibu11V7GzNSqg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eASsiL0X; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eASsiL0X
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F40664004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:01:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b4883643ccso2826685a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 07:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793545272; cv=none;
 d=google.com; s=arc-20260327;
 b=pmXkfv5NPEjTS4Z5N9j/KPTvU29DKCEIleEKZKFSisgjx7tEevx1n+SIntjWMTZtl8
 yrix6yaRO37uSpwLPkS/EqRYaIgJOe7TzKXh78pf9JNF2SeVEFPOlYcofTM6xE32VHjT
 utEOCliurVK6f4UVq2n4OYeuJmJJ/mnSYuIYwFrxoutlNVY5LwASQYh+TFP2NQuKtaUu
 EBwE4Iw0HbNlMEXb+lU56G02blDkvZNi3Mvp9FtDcJQsEkbINVL3WkTUTrE8Idy2ggFF
 HcxOmEYqWQOYB1D9geLhX4RQ3nMoFqFsH0qykgiakNohaQMUAJYI3ikEMGp4Nt7GdoI7
 m2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=IogoNDXSeGX8gCD2Ni51aCnvJEmys7wKaklf21/n+gA=;
 fh=tgqzzhBUqE3yM4X9mWsKE+y/Dd5z6n689xjmBFlIuiM=;
 b=lYbVRG8UM9XI5GI0tBq4vsoPyDV2jVE8OTVmS8C9cqRW4HzM1Pn1w9icniKpRQBpqH
 nvyFS8is7Pd8/iGbwK92wASFhDeGHubuh23ITS3HmnR9Pt3/6fnoL9HOPxKgjlQ1yoOp
 97HsFSqmB9foEfdqfC7rnEcvXtCnM2iCXVRncv8WGvSjV1Zzk0Chv5N8jFj+FHhggf48
 +DA/2k+qpAnYj8L/83EHvTmM8E8ly+sIIkIhY/GPL3iRv1xLK8zorLMcHNj52LJchLh2
 UKOEijLhnHTIFfHRrD720QhkHpw1ObBajYI8ytabWFgUhFROGGDqknpBK7nPpQ7bVS7b
 nvCw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793545272; x=1794150072;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IogoNDXSeGX8gCD2Ni51aCnvJEmys7wKaklf21/n+gA=;
 b=eASsiL0XnugWBbZP6H9SzkRmSP4iChQCeDJbFhkhQYBHVm1kPgB7YA/CidR2JhOc7A
 KjmaeLNFC6PxQLP6zQFt+eMZ3H4p+aiGdc4k3b4+PD1KIu3shaCCV2WJwqDeCfgLzWS5
 c4QujMuxpZXeAu2HizDOTYCGHine8LA5+nYx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793545272; x=1794150072;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IogoNDXSeGX8gCD2Ni51aCnvJEmys7wKaklf21/n+gA=;
 b=S4q+M1ziLcIjLxePfL0bABjjQVvvOUE5fx/SX9xaF53nK3cp6ovs8BIIfyj3TrMKxB
 MKQsmoc2DKPvBZrQibm2yGuB1IniitpDzGYikOJ0z3tyE6pLzzzyJNh7u3nxUF979XYo
 d+QVwsH2Mt+GKndLP5pLRvgIlfjNzFG/9mv70QNLUEf9yY93qzWOx+p6oJpr2WRlwMIn
 JcxnYCLDOcWyolwS3gK4d/WeCdPMapYT2bX7PrXfKkoxdmLn6J2+AlchObgvY/VlJcuU
 QUDO4joDP3jmUeOpQvc3Dz+Ly1VtDT6TlFx/fgPUrxTAkGhas0nXsJ5H/YcLU0jiqaZM
 1lRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOBcjSDbgrw0BXGXQQnIWLYDVrTXnQceOjAhjpmbXRnj/C8KzFLxgFHTkSQBKLSDfvKwlYZFs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+nUXcEa+8cbmnOl6WHXlNlJ8imHPTDpu2Kmr6VfoIC/tIB0BT9
 BslCKGSZwzQBcNjXepNdeBwrIIIgzVnOdxAble1T/QYzh8sJL0K9oTUPklNFTGYVz75Yt2CpxKo
 WYMRuSecrwXC2p/KTTc7vruN3aLaqFFdcVToLsnzj
X-Gm-Gg: AYBFou0Scc2A/TzExr93NHnWRt1LIcGjU/h3kHqGWkaL6IjEnGBzhfsfPjY4xZbXJx9
 NlnP/7NWfYl+TuUAh7qrwbIjdEEDWUWEnkyt9tGMuGELerPCzPCk4K1W1tKfDqii2r0VwEh40Nk
 G3CdgmjMRafsrpYfjK5xLShUjxiXTSE+vi9nVQrT4HgTX0fu6WkNTW2zUVIz2Gmn9VkW+TcCztd
 yNhha5J0KKegUkDg1Qa81MybRADjhIn/TLXN/0hjQZZiaqxA1Dqbrbl03jpxpLciGZLXp8o+R6n
 WQmbHwVN1gE5qY9EhUWnNGQc8u04cLutPRfRFYcIDpQ9ZoM0xu3N2S1J0rBMQwY74QKqedrIqcM
 vvdmHRvqqBAvVs48zNTdtrJdUuF5cUmhymB+OfeWr3lktD62Pnj3BMUMo0oSplWYIINUQLDQA2U
 ol8EWZEgaVc+1w+lj/
X-Received: by 2002:a05:6402:a50b:10b0:6b4:27a:38f7 with SMTP id
 4fb4d7f45d1cf-6b4d46841c0mr3544541a12.22.1793545272610; Sun, 01 Nov 2026
 07:01:12 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 10:01:11 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 07:00:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <10123a81-af26-4fbf-8bb1-f6c66c5849ad@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
 <10123a81-af26-4fbf-8bb1-f6c66c5849ad@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 10:01:11 -0500
X-Gm-Features: AclHuK92V9dbeAL28aUgX6nF8l6-y389Qbx7SXYkJYQL5BJ-7avB93NQQ3gnaPM
Message-ID: <CAFLszTg-PE1kU9pYp0n8UiktNr53wRQnU2AgfMxmUF9CccVKTg@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] mmc: Always use a 512-byte block length
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-11-01T07:01:22+11:00, Ana Bobillo <anabobillo3@gmail.com> wrote:
> mmc: Always use a 512-byte block length
>
> mmc_startup() sets the block size of the card's block device from the
> READ_BL_LEN field of its CSD and only caps it at 512 bytes from above. A
> card reporting a READ_BL_LEN below 9, which the SD specification
> reserves, gives the block device a block size below 512 bytes. A block
> that small cannot hold an MBR or a GPT header, and the partition and
> filesystem code assumes at least 512 bytes, as the patch adding
> blk_valid_blksz() describes. Nor does the code bound an MMC card's

Two nits, neither worth a resend unless something else comes up.

Once applied, 'the patch adding blk_valid_blksz()' won't point
anywhere useful. Please can you give the subject of that commit, or
drop the reference, since the sentence makes the point without it.

> code already did in DDR mode and as Linux does for its transfers; the

Please use 'does' here: before this commit the code still behaves this
way in DDR mode.

> WRITE_BL_LEN from below, though mmc_bwrite() then writes blocks of that
> length where the block layer passes 512-byte ones.
>
> The check in blk_post_probe() does not catch this. It is left out of
> SPL, TPL and VPL, which commonly boot from MMC. In U-Boot proper,
> mmc_startup() runs again whenever the card is initialised again, by
> 'mmc rescan' or 'mmc dev', or after the card-detect poll has seen it
> removed, and sets the block size of a block device that is already
> probed.
>
> Use 512-byte blocks whatever READ_BL_LEN and WRITE_BL_LEN say, as the
> [...]
>
>  arch/sandbox/include/asm/test.h | 10 ++++++++++
>  drivers/mmc/mmc.c               | 34 +++++++++++-----------------------
>  drivers/mmc/sandbox_mmc.c       | 11 ++++++++++-
>  test/dm/mmc.c                   | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+), 24 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
