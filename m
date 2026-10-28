Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48D606A32D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fJv/Io6k;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6CitNSg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03CD580DE8;
	Wed, 28 Oct 2026 09:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WeaglxJqQvc; Wed, 28 Oct 2026 09:57:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D4E980DE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793181423;
	b=BOneJK+O/4WnmEtXWdNSs+eEjvFVeiV2ITACpMQUR/G364OHUbCt+W+PHTLT1MxN+Lcd
	 vnPSl6t18d8rKTMbPnX667vxdEwTQhBxqs/oJ/AJ+EPs+5qVWhkl76ezLzLC5PNkP8dmU
	 YTsng2PEG9KdyViLl0FokUpMWHU7BuzmiuT/hSOeXZxgGD6Q+qZ2f8zmgAqfqXWmjMjPd
	 nu/20rFsPp0ePxQ9hosj21LRClpV9JujiRE7NQ+HZtj+avMH8SCD3Ys9dvbaAhoXrXqRk
	 ZS2VQEB73b2yWhtWc3jdEQwNRFf8PZ8iNCzpQpbY4uYtd6C8KOg1/BmV5E1XwhlcxGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793181423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qFQKtzj6jdSST+G6dHGhhDDYPB2k41X82O6nPDz1eWU=;
	b=NkdfSA5gFapmsHgjZm9gEyteaqwmhftBfX0kD+fk6LUsRtdroyzzMg17kvpIEYZa92L4
	 OLdvgNbYosQG0zLm267GOKelSg1WqKAf7j5vTmxX8ogEz4Mi0YVx4yJE0Gn+0cLD/wFR3
	 uri7dVA15L0EtL6FUSvSnkX5CElbhXXZYhqwaOWnzSr666dl2Hqf995AjhQXtR15vYaxk
	 2NuABrCKRJAQN8xoCjlLYIWg0RZ6SnNA5wSLt8Y1CI6DNSNow9OAKHISHRNrSLpStm4+1
	 4r+ngPXNkG1Pv4P02BTmkPh8ZbB/zNZsLN0zTa7EMUcGXvj1Teg9P0EP5D6l8spB0sg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793181423;
	bh=qFQKtzj6jdSST+G6dHGhhDDYPB2k41X82O6nPDz1eWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJv/Io6k+VlnbzaPZ6C+dctv/MgqsvCnTDb5W0juVpgw24igdTLxFRAF0ca4EgSo/
	 i1360sT4owqVsT+SdpaLxMB/RvttfNjPu375XqVH8a7B5r/LFK8X2UOrAca72kMHrV
	 QqdYHVMnfv3vM5FuJyJT8Um0pjKitpZHiVTKvw63xGmqKkEWgv2p++zvvt1pv2e/Ht
	 kbnZIO5fMpVdVT9iphtbqNa9ImHCoftOrhgqSgzST5q3AvI2X5ZZYsZHRYeTat0twI
	 hWY9nLhO1Bguq80C5HI0UpDJ69hKs5Cuvl0q0IWkMmFKDqFAkkgfb4GCc9YqLKHBYj
	 1S0oINma0rmVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D4E980DE9;
	Wed, 28 Oct 2026 09:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B7BD1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21FC1404C9
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hImUCIvvyMHj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 09:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 522DD404C1
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793181420;
 b=mOVPQUa+PukvullVH4FfCT8jaEN3zR9tidCN6Js1JlrBC0qOTp1Vf+IwEAWl5L1BqsVg
 tlgm2Olxp/lyPt7ltAvM9I/HY0SichFKv2Lc9p9fIlj5cAagz8tWDuPW8YcWVEOIOze63
 EuY0EwxBro4D14A1cuSAKBES/WMQL4iCh4nVg3NZADiJI20UF+wmRZU3t80AEfYv5BiCt
 p4hOVdCjR1LYZUMJWhlQnZRs4ayq2/732Uc2A5PxU5f4Tmi2pJ5BhOugoonGyPLUODjPR
 3qSv5qu68RNOZUHjQ/Wp1BqXl3IaE/Xfhk0DGCflk769OaCYFdeiHdP6/KSiywTnyRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793181420;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=qFQKtzj6jdSST+G6dHGhhDDYPB2k41X82O6nPDz1eWU=;
 b=hd/3H9YI9u1rxI77EDQVITY8qU+JeT6Z/8/AftwKfgCEFiS54Y2e2AlWwcRYUgH5WF8q
 paPRv+1mixpOiCG9TmsBwMt4x2x5HoxVQz1JyDxFiFvTTlpUu5NxsV8226C215Kucy2ze
 733DlGRGRskc4Gjoi+kBZaAXYwCAW/ZlyzQankxnWHiwcm38xHgmOt4X8LMPlM87gEEaZ
 NuIyZywzwGYIG794H5dmOqxgjueHopPB6k/Km7zZVf3GGNo4hgcwxZKdHljxCTV5TPjot
 UjvRYf4kgXTL+XMUhZ9VEGxO5hOPvgiBQqkTgDGQhZtwa3OW5ky51bW2hI4AotzVtyQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=G6CitNSg; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=G6CitNSg
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 522DD404C1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:56:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEA4943B10;
 Wed, 28 Oct 2026 09:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6251F01828;
 Wed, 28 Oct 2026 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181418;
 bh=qFQKtzj6jdSST+G6dHGhhDDYPB2k41X82O6nPDz1eWU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=G6CitNSgx+5nb4tEErm6AifNiiX39VZA3CQSUfRe3FW+q9HbuIeoaYFGTMTVtDq+a
 yjMRaWPYjctbBFr7pw936LrnmgZkragT7NSalKQNN2BaGa86/nJcsLhxkHmaXuXPHi
 8h//n3BUQFGy7l7XpJYrIWUxdzbERU0TB+SfUJXbib5KsjOmTSdEKwlQ+OqbsBgov/
 gdukLLbzAIudmyPHTTz7onT/RIh6UCOoqj2t/p+5vwv6CC2clN6JiILGTuSx5hVPt6
 iNzSU10pVoX6R9gcSUwz5s/rZIdkMa1nVZI++jk04b47kBTf6fWvjjjL060vWz2aVU
 CDL8GQ+57TUZg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Cole Munz <Munzzyy1@proton.me>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>, Aristo Chen
 <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, Carlo
 Caione <ccaione@baylibre.com>, Julien Stephan <jstephan@baylibre.com>,
 Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>, Heinrich
 Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Petr Hodina
 <petr.hodina@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 =?utf-8?Q?Jo=C3=A3o?=
 Loureiro <joaofl@gmail.com>, Siu Ming Tong <smtong@axiado.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <20261027012709.GA2177077@bill-the-cat>
References: <20261027012709.GA2177077@bill-the-cat>
Date: Wed, 28 Oct 2026 10:56:56 +0100
Message-ID: <xhkdb8q3i2lnb.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Mon, Oct 26, 2026 at 19:27, Tom Rini <trini@konsulko.com> wrote:

> Here's the latest report. Since it says 20 out of 25, I downloaded a
> report as well and the 5 not listed here are:
>
> CID 470520, Uninitialized scalar variable, lib/zstd/decompress/zstd_decom=
press.c, ZSTD_errorFrameSizeInfo
> CID 470520: (#1 of 1): Uninitialized scalar variable (UNINIT)
> 2. uninit_use: Using uninitialized value frameSizeInfo. Field frameSizeIn=
fo.nbBlocks is uninitialized.
> 700    return frameSizeInfo;
>
> CID 661171, Untrusted pointer read, cmd/gpio.c, do_gpio
> CID 661171: (#1 of 1): Untrusted pointer read (TAINTED_SCALAR)
> 16. tainted_data: Using tainted variable offset as an index to pointer uc=
_priv->name.
>       Ensure that tainted values are properly sanitized, by checking that=
 their values are within a permissible range.
> 238                printf("gpio: pin %s (gpio %u) already claimed by '%s'=
\n",
> 239                       str_gpio, gpio, uc_priv->name[offset]);
>
> CID 661172, Overflowed constant, test/boot/fit_cipher.c, fit_cipher_test_=
oversized_unciphered_size
>         info.size_unciphered =3D sizeof(cipher) + 1;
>       2. function_return: Function image_aes_decrypt(&info, cipher, 32UL,=
 &data, &size) returns -22.
>       3. known_value_assign: ret =3D image_aes_decrypt(&info, cipher, 32U=
L, &data, &size), its value is now -22.
>  65        ret =3D image_aes_decrypt(&info, cipher, sizeof(cipher), &data=
, &size);
>=20=20=20=20=20=20
> CID 661172: (#1 of 1): Overflowed constant (INTEGER_OVERFLOW)
> 4. overflow_const: Expression _val2, where ret is known to be equal to -2=
2, overflows the type of _val2, which is type unsigned int.
>  66        ut_asserteq(-EINVAL, ret);
>
> CID 661173, String not null terminated, boot/bootmeth_bls.c,bls_boot
>=20=20=20
> CID 661173: (#1 of 1): String not null terminated (STRING_NULL)
> 7. string_null: Passing unterminated string label->name to parse_label_ke=
ys, which expects a null-terminated string.[show details]
> 309        ret =3D parse_label_keys(&body, &scratch, label, true);
> 310        if (ret < 0)
>
> CID 661174, Unchecked return value from library, drivers/fastboot/fb_usb.=
c, fastboot_usb_run
> CID 661174: (#1 of 1): Unchecked return value from library (CHECKED_RETUR=
N)
> 7. check_return: Calling getchar() without checking return value. This li=
brary function may fail and return an error code. [Note: The source code im=
plementation of the function has been overridden by a builtin model.]
> 48                                getchar();

It's harmless to ignore the return code of getchar() here. In this code
path, we want the fastboot session to be aborted on *any* key press.

The tstc() call just before the getchar() ensures that a character is
available.

To me, we can mark this as a 'false positive' in Coverity.

>
> And I can provide more details on those specific issues if someone is
> looking at them and doesn't otherwise spot a problem.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Oct 26, 2026 at 6:53=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 25
>    - 13 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 20 of 25 defect(s)
>
> Defect Details

[...]

> _________________________________________________________________________=
____________________
> *** CID 661187:           (TAINTED_SCALAR)
> /drivers/fastboot/fb_command.c: 952             in flashing_unlock_allowe=
d()
> 946     		sha256_update(&ctx, buf, cnt * info.blksz);
> 947     		last =3D buf[cnt * info.blksz - 1];
> 948     	}
> 949     	sha256_finish(&ctx, digest);
> 950     	allowed =3D !memcmp(stored, digest, SHA256_SUM_LEN) && last;
> 951     out:
>>>>     CID 661187:           (TAINTED_SCALAR)
>>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an=
 offset.
> 952     	free(buf);

False positive: buf is allocated by malloc_cache_aligned() of a known size
(FLASHING_FRP_CHUNK * info.blksz)

The data read by blk_dread is never bigger than the buffer size since we
have a cnt check just before.

> 953
> 954     	return allowed;
> 955     }
> 956
> 957     /**
> /drivers/fastboot/fb_command.c: 940             in flashing_unlock_allowe=
d()
> 934
> 935     	sha256_starts(&ctx);
> 936     	for (blk =3D 0; blk < info.size; blk +=3D cnt) {
> 937     		cnt =3D info.size - blk;
> 938     		if (cnt > FLASHING_FRP_CHUNK)
> 939     			cnt =3D FLASHING_FRP_CHUNK;
>>>>     CID 661187:           (TAINTED_SCALAR)
>>>>     Passing tainted expression "*buf" to "blk_dread", which uses it as=
 an offset.

False positive, same explanation as before. buf is used as destination
buffer but has a known size allocated by malloc_cache_aligned()

> 940     		if (blk_dread(desc, info.start + blk, cnt, buf) !=3D cnt)
> 941     			goto out;
> 942     		if (!blk) {
> 943     			memcpy(stored, buf, SHA256_SUM_LEN);
> 944     			memset(buf, 0, SHA256_SUM_LEN);
> 945     		}
> /drivers/fastboot/fb_command.c: 952             in flashing_unlock_allowe=
d()
> 946     		sha256_update(&ctx, buf, cnt * info.blksz);
> 947     		last =3D buf[cnt * info.blksz - 1];
> 948     	}
> 949     	sha256_finish(&ctx, digest);
> 950     	allowed =3D !memcmp(stored, digest, SHA256_SUM_LEN) && last;
> 951     out:
>>>>     CID 661187:           (TAINTED_SCALAR)
>>>>     Passing tainted expression "*buf" to "dlfree", which uses it as an=
 offset.
> 952     	free(buf);

False positive, same as previous one.


> 953
> 954     	return allowed;
> 955     }
> 956
> 957     /**
> /drivers/fastboot/fb_command.c: 940             in flashing_unlock_allowe=
d()
> 934
> 935     	sha256_starts(&ctx);
> 936     	for (blk =3D 0; blk < info.size; blk +=3D cnt) {
> 937     		cnt =3D info.size - blk;
> 938     		if (cnt > FLASHING_FRP_CHUNK)
> 939     			cnt =3D FLASHING_FRP_CHUNK;
>>>>     CID 661187:           (TAINTED_SCALAR)
>>>>     Passing tainted expression "*buf" to "blk_dread", which uses it as=
 an offset.

False positive, same as previous one.

> 940     		if (blk_dread(desc, info.start + blk, cnt, buf) !=3D cnt)
> 941     			goto out;
> 942     		if (!blk) {
> 943     			memcpy(stored, buf, SHA256_SUM_LEN);
> 944     			memset(buf, 0, SHA256_SUM_LEN);

[...]

Thanks,
Mattijs
