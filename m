Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC3C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B021880C5;
	Sat, 22 Jun 2024 18:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bjhEOuMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9042388080; Sat, 22 Jun 2024 18:03:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A039387A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719072195; x=1719676995; i=xypron.glpk@gmx.de;
 bh=EbKUzGNzILHlcZ1OCu++nubN8pqXLR0mTheAVTqiH9I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bjhEOuMAxFnQRKlTv5m7xdFZz48vtVTLRC0rUt9JUzujdveyV9GTAOn7L2Q3p2Xg
 ZGiEBICpwgSt0S/A/e6oPJkbL1HDrWXPqLn/lSy88rEQfGMPdmHItUHXKb0xcd6Dp
 0R/M+BiR4paIqq3gXqGlQcgzQGhC3ZH6U4Vf8DSdD1Gx9eIf8eNV+Na5SGEC5vP27
 DV0ag5i8Nj0sq09Z2adFL5fj8f26UgtBLQI4eIPBOzlwPTGs9lUDtJ2NlXOOlJMyU
 CbGaDfYfoV2J9rLl1aAoa95GYHoPHYmuUXEkZSgVJwcy71JXUWzJEdDjurbRMCS3T
 n5VvbY7y0pbDSHzjFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1smNgd2ljQ-00eBVQ; Sat, 22
 Jun 2024 18:03:15 +0200
Message-ID: <023d85a1-40eb-40d6-ba3e-5d777fb2564b@gmx.de>
Date: Sat, 22 Jun 2024 18:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] efi_loader: remove duplicate TCG algo definitions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240622143601.187723-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GVHQAnSiGq8Jka/EHwL8eREkmwNEEN9iJNo/QN31asD34vAhFJm
 YocAGABCvb6bU2+7zR/TmsILx8hj/nGfy/9bFVNppK6HJoFTCAIv3ohARx7QibzU0PKj8JN
 tllSer3n11MUXlMIItfq8I1oaNYYGKCQklvle01g8Jg4HQf7LOUhHZI36yDkagLcAfQKbFk
 vtNXifzqPZ4QYLxNoqndg==
UI-OutboundReport: notjunk:1;M01:P0:w71hxkAqVMI=;3Nr+y9mcMQ9yVkghAlu0FxTr/jv
 ukJbDlc/34PZU3LUZXQXYKrEW/QDQvXFHiOQbqbez270fGsLuZzV6cDTgnv7EoJTQOZTtmUov
 jG4fmbmik9lOMup5j5eiNKAsoUM5htzawGwzQCQp1BcJo5lFCv0TZAWtAGpiDQGkplp430fd6
 qbK12mBUb1aj5n28Qy+fnjRRJV+95r7VYyJcUWhOwYPKSowL9stjuICLZkHggY+31UFO8ugAI
 W8OIlbDceqiakApof88lB5p7ON2zkUW7kme/4DGgGGJn/4gMhwwEpJzWhNvUOsOKEa+7SXUwp
 34oOjKB2aL5M1yZshK1gnTuAUMMgqsrIG5bISrHzL3C7qtsoaaDzaelazKHXznF5xyVOObTlZ
 lzzAzHL9RbnxyrhS/RxtvHSx2lJpuhaCbhU4xNYkrf+xY4d60msDptm4wAMNd4rDj9vgsjTAd
 ODgGOc0YSoWdpU8osDsaXBZYwhbgrwg9l5pqSkzgbXPnI+rbaWxlNgb5HJzou5ET2xxiQAa6Z
 ZPvG2D+9abZMFyi3dOi1MtN30y7TAy1g7N+dYlBcjBGDvibCqoeQo+IJ/r5bhjd66mHRgs3br
 sG/ZiEMFWoGm/QxGQvJzsxo1NTpR7OD1HQv9+rmk2arUHVe4v+v4QEbqn9FW0ra3NmwSYcrmy
 8DY0h+LkCsioTBIIx41Gfjoko8aAu3UssG05+KVHoCffOkS/Eoi+ikkhRL4syPbL9rqIsioaj
 AOTL2LH3G0Dy12WyfQM6UN8w+7Q7uMc/4k2oiWXxaDlfDrkV6lG9ikNtd0ursdBSwprsTRyJS
 qW//LTddRjRgIyvtHeknBpCPWvr9OcNJDdP5e/cfRG36U=
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

On 22.06.24 16:35, Ilias Apalodimas wrote:
> commit 97707f12fdab ("tpm: Support boot measurements") moved some of the
> EFI TCG code to the TPM subsystem. Those definitions are now in tpm-v2.h=
.
> Let's remove the duplicate entries

The constants are not duplicate but unused.
97707f12fdab introduced different constant names (TPM2_ALG_*).

Otherwise

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/efi_tcg2.h | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
> index a75b5a35b6e7..54490969b2d1 100644
> --- a/include/efi_tcg2.h
> +++ b/include/efi_tcg2.h
> @@ -25,14 +25,6 @@
>   #define PE_COFF_IMAGE 0x0000000000000010
>
>   #define EFI_TCG2_MAX_PCR_INDEX 23
> -
> -/* Algorithm Registry */
> -#define EFI_TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> -#define EFI_TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> -#define EFI_TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> -#define EFI_TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> -#define EFI_TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> -
>   #define EFI_TCG2_FINAL_EVENTS_TABLE_VERSION 1
>
>   #define TPM2_EVENT_LOG_SIZE CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE

