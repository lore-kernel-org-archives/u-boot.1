Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B872606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DKAAX65K;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Qillh5+L
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E70AC60613;
	Fri, 30 Oct 2026 12:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T4dPuuJroJBC; Fri, 30 Oct 2026 12:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25D74607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363743;
	b=H81SikfyNY4Yd45zLjlM4b6x+ENzGN2MvWqoDVto85Bv6sHdH6e0mS0reKMXRp0qvrgF
	 6iK1+upkndwyHzC7WbZ4j01P1ygCCjA8THm+jmeHlKK62AlslKs8OjnAcZBgiwOEcN3BH
	 A9h81yLj7F5Gw7Yr2h7AQCbNOS0+trcYa8pibELrJNyplg5L1YSnsQjx4OEemwQ7hP06f
	 fhqSqwK1Ewo9dfga5wrU+dgN7oCkKAhu5B8ydnabCqvEnYg0wl83lePTYjZLlhSqBIUiU
	 qzYhvUAP9EcKGzTKHQWXqekxg7gsh7pOF0a2ArG774m47wnyS0rPJ4Zpvz/Fu1XyFfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q1z5qbMK5ZXnmYpOwvpcrDuK1MN/UbNCdBYfxKfydtA=;
	b=iL2QGKS4FiTAAMt/KL9YP29T9k7uYzw9P8VCzYIJ6uOJXSuC7GEP8tQVlcPgktqbUjLj
	 cWrt3EVeHodqgBYal1VKNFZsDCmsuKlUEpqsMX8iGcbRN8xPKFsLlXXEoY69Z54gisG0g
	 QbFH1pFj1kTs9fX4EBWrVc3yDMwAcmyq4vt2lYC6qL2hzmNbkamP8c5TCAG7wweAPxhmI
	 Hkx16KhkY55+m6zNya3k0V60UdsqGfHjO5anTlY9SGf4U1Ck9eUkFn2c2eu8NsZHJsOqK
	 VDs+RRqXQKji+5jL+PS8YyuoHy0dpnSJQ+HpPBxERDWpuAWlfHLqrHWhvNblJNj8zRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363743;
	bh=q1z5qbMK5ZXnmYpOwvpcrDuK1MN/UbNCdBYfxKfydtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DKAAX65KLRItn18elzMtID3ggDqHJK4ZjDS8J8NhXysshyNQM5vq+WVBH/Q621bgC
	 IslLHWLxbo8IX1ar7Y8nFQb+ntmKRqqflJ8TdcMJ6f4SVjSuy9lbhjYvKNlJSJpvL0
	 CQAWlM2nDTAUMvIpq2kq5cciPvhVlf9Lx8TSaO2+Mff3PVUOeiArCBqHaaDkz8CPys
	 SvHgqKAiwkiAxq14GS94dTVzDJJYscynrJO5K8OJiuJGjt44QHeTvnX3Z2LwhSdpa+
	 ySr/ZbeUeB0HDPOhXOO6LV9g7UdeoWvbvyThrUYyRwU7ORaxcBv1DUSa8aPWi+L8Dx
	 n2mNWSMpvnNGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25D74607A0;
	Fri, 30 Oct 2026 12:35:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 206FD4BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 060414052D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TlSkweYg0F0a for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B41D140243
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363741;
 b=itCVbByfZO0K/BIkGid8Ek3Sxq+iOJirj82EHIvTj4lgLf1ptTS1/MijhcsOACyv/geN
 9A/B/mnG7PZ6oLC7zekgNVr2UzszIsvMUXLY5x+HgPtGm3RGdo1mcamu2eF/EK9QrGtXN
 pSvUGzcU6zWtRCINhs4uJ7hb4hQBkSXXD+kMvBJ82isSB1orPNWEnCXLBVsaOsOOwQKf2
 k716GxSlJnRYGPeXqq712c8rA1AkVOjnVAFsg2ddkoQZlzX3vudEYQ8WIewCt0Z5tP34w
 iWLk3yMScZ4GttQqa5htzEuHMKOOJR/6rouT8WO/IqZjdfSnwDEOTe+qAEdmHuhDX0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363741;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=q1z5qbMK5ZXnmYpOwvpcrDuK1MN/UbNCdBYfxKfydtA=;
 b=ZC7PYBj5jPSr+R99GV5bYxpp7stYPr5dXTCV0LSv/lwYttFs1UdCxm2ia5KjzPcx90HH
 Sr+cIj8iYNBIikct3iQm9wkgyVE6aRx8YMO57NrK3IFt97AOaWvGZIw71mhc3VpkvrKSf
 ciFfsX1/nG4F9WtWJkJkxwNV7+Sg8Z20qGsQ0/IxkzRnWpkCHgkdex/rp+jZCreXVwrUU
 +o+jMMJMr4f30gnbdGsRBh1s6XnN8eRSwuEo1ijF6hNdXvdSISTQWXwFRbNMNhKlcYKdh
 zibCKa5k8yW6gNTywolYyL9TmO7ylnVBQwPp9NuEulCPVFYLaFj30p5G12sLohtl9Kw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=Qillh5+L; 
 arc=none smtp.remote-ip=212.227.17.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=Qillh5+L
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B41D140243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793363736; x=1793968536; i=xypron.glpk@gmx.de;
 bh=q1z5qbMK5ZXnmYpOwvpcrDuK1MN/UbNCdBYfxKfydtA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Qillh5+LbBTMrRXrfo29TUypORTMnUX+HSGQyGN/zPmKeUMxXg7vlAwb+BvgW4AR
 NWWprGoD6xybpzdBgBQTwXvF1YpDga+Yu0FYJ3pJImWUTq0+X8hAbHciHRaegLObt
 qfLbxotwSxJ/w+JcfjDBC+HlvqegOVVyzBN8nHggNyq82GQYwfzm4DgnNsYAw4fow
 jajHg2eykrTKvjYMZdEke4fPtbHpXOD2XnifNvB7uWtT10qPxIc3EepgNBGObbdLV
 ePzcp1yBOSOUBRz0cPxKbMqDY2tqeKQ15BuIxnEwc5BFsRq6IoYGIZQZfHhuGEsER
 j0VY7ZnZqmeuNyGyLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1wRpd03ngP-013c6c; Fri, 30
 Oct 2026 13:35:36 +0100
Message-ID: <f3dbda99-feec-4f5b-90a1-1b1b8242f5ec@gmx.de>
Date: Fri, 30 Oct 2026 13:35:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] efi_loader: reject a PE section whose end wraps
 around
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <5b986292-b889-4e1e-9e0f-9012ea225366@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <5b986292-b889-4e1e-9e0f-9012ea225366@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n7Yx6/6gCLNJUzvXgoR1F7ko7FsdAj4L7mMDHCWJc65wCH6YDAf
 aqM7DWfJqSykjBL1PfagQxdj0zpGIngTXrxTRCCXG2cqiveztsNWhE4tRSSm+DDuifmEION
 wNrJhB4Q4iRXB3OWbx3UfO3eeZXRlwymSsMgxyNuxcNcBFCJGwUG+BHv8scoS2fuRTp9gnh
 ++N+THVOqCqQ/An6U+tew==
UI-OutboundReport: notjunk:1;M01:P0:kploP65C6Fs=;ehPeGyUVTKntin5ebQtBCUluxyW
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 07:13, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> efi_load_pe() computes the end of each section as the sum of its
> VirtualAddress and its size, both u32, so the sum wraps around before it
> is widened to unsigned long. A section near 4 GiB then yields a small
> virt_size, and the memset() and memcpy() of the section write far past
> the allocated image.
>=20
> Relative virtual addresses are 32 bit, so reject a section whose end
> does not fit into 32 bits. barebox, whose EFI loader is based on this
> file, fixed the same in b6598389d46d ("efi: loader: fix integer overflow
> in PE virt_size calculation").
>=20
> This runs before the image is rejected when Secure Boot fails to verify
> it.
>=20
> Fixes: cb149c66342c ("efi_loader: Add PE image loader")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   lib/efi_loader/efi_image_loader.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index 35cf3cd268f..b15a662e5d6 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1062,9 +1062,20 @@ efi_status_t efi_load_pe(struct efi_loaded_image_=
obj *handle,
>   	/* Calculate upper virtual address boundary */
>   	for (i =3D num_sections - 1; i >=3D 0; i--) {
>   		IMAGE_SECTION_HEADER *sec =3D &sections[i];
> +		u32 end;
>  =20
> -		virt_size =3D max_t(unsigned long, virt_size,
> -				  sec->VirtualAddress + section_size(sec));
> +		/*
> +		 * Relative virtual addresses are 32 bit. A section whose end
> +		 * wraps around would make virt_size too small for the memset()
> +		 * and memcpy() below.

We use  unsigned long virt_size. So wrapping around may not occur in the=
=20
original code on 64bit systems. I think the comment should be tweaked a bi=
t.

> +		 */
> +		if (__builtin_add_overflow(sec->VirtualAddress,
> +					   section_size(sec), &end)) {
> +			log_err("Section %d virtual address overflow\n", i);
> +			return EFI_LOAD_ERROR;
> +		}
> +
> +		virt_size =3D max_t(unsigned long, virt_size, end);

The comment above says "Calculate upper virtual address boundary".
The parameter name virt_size only makes sense for a variable holding=20
(max(end[]) - BaseOfCode). We should probably fix that misnomer in a=20
future patch.

Best regards

Heinrich

>   	}
>  =20
>   	/* Read 32/64bit specific header bits */

