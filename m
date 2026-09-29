Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A00CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 17:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 482D6403C8;
	Tue, 29 Sep 2026 17:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jwqt0awBLZre; Tue, 29 Sep 2026 17:02:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7EA2B403FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790701343;
	b=Pp/f7MXGd4oRGJDwLcoXwGLqt+7jidDAs1BOzk5WrPaLBS6RrMdQrTluNyLOgfHu/QAC
	 UBtbHNhyKb3nTSCbOmk2Iso4FabnTCa2D1oALnwVRgDfFVrrqTSE06A1/TRGNN+gWsIED
	 Hnr8FO8ypoKy2kJxep0AR6FnqUIALNg2wqFNaMasrZodEA/C9JEO0lSNG0gFmROBz3Ob+
	 TauVdwvIwOsRe8q5Sqzd9A9avy+qSl7g9hVlvwk8BhoYFlKh2tK+/maOVxW9Wfqxp37iV
	 JpAJptJH1S9+aoM2fxYZXGi2cjGZz51zK9s2WsThkiRyc6e0ar+pjqdHExG3PN2EIYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790701343;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LGWQEt73DMbsUHy6VJts7Sq91wOskThko/KLbNsa480=;
	b=IYKKncCJhVdjlRFHRS4lkEl3a/ORwU6GbgJEz/l94ut79lODErgmsqnpNLVWG21PA7xi
	 I4WWbjy9Zjvzlciz33j8sh/GaWKPX/HHepRIkt7ij1VCfUJ6WAs59OBfz7j37dQPiDHeR
	 FYqQfraKeA5QiI5XYllX0uwhDIuqx04Pm+n8Pwvtn9oVxiZKP9sFQpBgq6yBpC+0gsrPh
	 5unVLWcGMaBeKnFSUEexzr4yi2jVvU71HQjZO3X+y/iN/LI92qIEbc+aOwS6c4QSUSfKA
	 YW0HtvUWBoBLGzavZMiP3xYvU0B2F28bxk6l670UM7/ly69cJ/aa2sYc0hvxXWatJKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=byteray.co.uk;
	dkim=pass header.d=byteray-co-uk.20251104.gappssmtp.com header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=k6gETjqa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790701343;
	bh=LGWQEt73DMbsUHy6VJts7Sq91wOskThko/KLbNsa480=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u9Pn+lb5ErKeTbHPKRrIeXteKPbYxXvgWpqlW1Dswv4LxvwOiFqiDe4Ow0ve044gF
	 iv8c0Pt2+E85wLzbBQ6MbmoC6tbbQJQKo0WqLsNIiC6A+b8aVKthR+STyHGEyxYpqF
	 L/GisV5Usn5geR4kElRIrhBqCh3ItoDxdhc8G6NciTdVc+QcrCTq3kqTDrTW4ZMpxT
	 zfStICilxHaIyXCvLEgTbMjWThE5op2cUz1L8Sn3567qkasSeUnvDLrRpOR3nVJlH7
	 5d1qDmC1b3rHSxiQhTCTZZmfFe9UpGnE1ySFnX7UovIuFXDdA92raJD6KncOsgzHMK
	 cN63gPBV3SSgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EA2B403FC;
	Tue, 29 Sep 2026 17:02:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA66434E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC01C40486
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVHtL57MBeqA for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DADCF40478
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790686994;
 b=IYZbP5fFNc0b4n7q1+eJAvkUxsjOqlrNGOCSczkWOlyxLINcmHrGT4C8DE0XAZBQsD8J
 uPdQywuWC4aM7QUFjJpKWZ2HSxVN80OE1YOshDqYdxWkgGd6pZquI6FAn0oRPboYfEEom
 Kb5NNb+WIwZbhN2I7FABb0NWNAvJkf/HizDhot5UKOb21Z7/rF3mbUc4PRkkCqEsrqNHU
 lEIJ/UN+kvLQaKekHueq85xAWwPVQLDkGYw+Nw/zn8A5GwJJ6bCLY0Dj8P/w6/klLSR/v
 w7EY932kxY2EtALYot5Vrp+5LDUfEE3ESkrwMSt+8ylojDtlkcbmTmXEuXndcHll87g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790686994;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=LGWQEt73DMbsUHy6VJts7Sq91wOskThko/KLbNsa480=;
 b=WauBJP8A0EGNN1qh1o8sgCG2jaRR1Q6IT0i0278e3AwTkqakSI6/qbfRCYiw8Ca3C9rm
 Kl32W6Nlj79VjbmYyhCjQnpt7Wam2EzfTwI0ozcWxCtwEcjqCP7mCGGWq0tyLAtW8Zf6v
 6yTmNcWsq6+oudE2O6/GFgzlv1ImaD9rsPu2dL+DKjQp2N3xLawV7sneeYhts+x/8akaq
 7MLiKQ3B6ga+bSGuRExzxwEje54hHBxwIDhPqNgtOuOTrJKSRUxUAkbY/X7imxRbIkfnQ
 RybLmm9qmKh+UU7T+ge1M2SwpTNkEdS60F5gu5AtJDksUSYX2oenIzYaADGXHkiBPbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=byteray.co.uk; 
 dkim=pass header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=k6gETjqa; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=shahriyar@byteray.co.uk;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=byteray.co.uk
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=k6gETjqa
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DADCF40478
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:03:10 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4885a1480a2so2451718f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1790686989; x=1791291789;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LGWQEt73DMbsUHy6VJts7Sq91wOskThko/KLbNsa480=;
 b=k6gETjqaJqdohcPJGnEShYwE30CdLOm0XFwRlSRGpw5YCpH/aBv58UVX84HjKAb5hw
 gN9Gkug1pusQw75OWC5UJwenA0sLLbVeEGFQDjcqtnX7t9zmayXD2iROipIf8FpkavlI
 M47AGmqGSRQCjvft9f+Ky59O6RqeUQNmPj/LljpuxBp+HQves5jDHY87y6Xjk1G2tgf7
 5kNctag0kh07MTlDKDRCLd3UJFopILpxe+66WGYZvC0oa/QPekCi0Xj2ry0n3hK18yi2
 AzoTa1aNbBRb0nDc8Ezb0OpRHtXw/956MIuTmygPbRv6rUcIopD64nJ7aCvo13YnoeyR
 K3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686989; x=1791291789;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LGWQEt73DMbsUHy6VJts7Sq91wOskThko/KLbNsa480=;
 b=fjKWjExu7JaSKg14Ya2OuleGcXeYr+OlsqBjfgzdyI/VdWoPsNKKAAO01GZQL8lWId
 NmWLFkCZh9qH7XD0HTiq1BJ5d7vN8REOvziT13phCGnMLORU5axp1u7VPew9VzGKFuQb
 7oM9p+y2oS/yLMoF76ur/oVRo0j6m7Cqdb8XGdptLjR+E8H26pYltI7GTsdwLJHsTPCX
 7tCe4LYH4b5RZkL70GRRdbUGdEq/BlxZL7yfvbXL1YHYA+fIoyjVYFJ7P9PvlliddbAV
 v1Kn7SmdcaaX2krctQnTWjXGKIHDbVfHNGHQEgDic7OJZCMOj8HXzIUR8MjpQBUzqT+7
 XDwA==
X-Gm-Message-State: AFuF++nNaQBo4iPUOR1rPs/hchNOWpw8Su25CyCfr9hefdC+2+5E1AMZ
 xpv6+OkH5Ckte//g8KXe3SFydYrkGT5gjeqW3OTjh5ZfzNtWMRM3HNHwbpauog1YIZhTc1mqYIS
 Wf0mCJH0=
X-Gm-Gg: AYBFou16haB4FpBZj4jkTe9YJGrdrVEZDMUvSkcvY0PYcEob5qjhSFVDLFT3No21GCE
 z4O6WR9t167aPAb7De0VYurLd7u+xqLefb6Mc3Nd/CDTtmVu3PdORbj8ykDouQR2ph0VMHR/lMi
 /AeOHWmgBWWx11k9T7gUvHSO2uI4NxuIWrBg+Lt4z5mLH4QyKrtxOSCJe6M38lmZdyRUzIhv/Z0
 y+TFIkDwrUxJRow7CMackYCuBWTJpESPsK3xPLPQkLxUjvL+DQXTdxZKZ9i6NBdtdYcVGwRApm4
 44aMFNxLgza6kms5uF/WHOYI3ZQcXuLsVgrVEUywDD9Aayp2w6Nog0iw747IhHBn6U7ZZ7keJmb
 JjyYaoRNV/NqvBUYjgTyZle82d8t4tEr23qjErqWecjyqtQRGiLZB/W0BNFijeWCs/IqnXDEhFn
 ryTioN6hcFKPoKZqfC82yxtpBZGuedgds3XWMrdJN+K+k4xn7b50Z0d8yDD1DK5Wf+jXnfFSpvY
 oqhxbRD7oMpVeUbwxSFFAiaXiuc4wGc0TvfyYtQl0BpiUM0t/J0OIQdsAVrNN912MKUP6kRGQIk
 cyHMA38Z7lRUKiZ+GLNsQTjX0nHoLsc2PDOYfWsB0KELvYkIOpDlhctn+Q==
X-Received: by 2002:a05:600c:8b86:b0:49f:ce73:7a9 with SMTP id
 5b1f17b1804b1-49fe6701ed1mr280487615e9.34.1790686988406; 
 Tue, 29 Sep 2026 06:03:08 -0700 (PDT)
Received: from ?IPV6:2003:101:5703:1800:697c:54a:8a5d:51c4?
 (p2003010157031800697c054a8a5d51c4.dip0.t-ipconnect.de.
 [2003:101:5703:1800:697c:54a:8a5d:51c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013d00570sm2452535e9.3.2026.09.29.06.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 06:03:07 -0700 (PDT)
Message-ID: <71222064-d97a-41d2-b811-38c0944bf769@byteray.co.uk>
Date: Tue, 29 Sep 2026 15:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] tpm: bounds-check device-reported response lengths
To: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>, 
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
References: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 17:02:22 +0000
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

Hi,

Could you please review the TPM response parsing patch I sent on 13 
August 2026?

Please let me know if any changes or a resend are needed.

Thanks,
Shah

On 13.08.26 17:58, Shahriyar Jalayeri wrote:
> A TPM reply's length is taken from the device and only upper-capped, then
> several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
> GetCapability parser subtract a fixed header length from it, so a reply too
> short underflows the subtraction into a huge memcpy; the GetCapability
> parser then copies that many bytes into the caller's buffer, so a reply
> longer than the buffer overruns it. Because a TPM sits on a physically
> accessible bus, a cheap bus interposer (the kind used to sniff
> disk-encryption keys) can inject such a reply, and on the TPM2 path this
> parsing runs during measured boot, which is exactly the physical attacker
> that measured boot is meant to resist.
>
> Patch 1 checks the reported length once in tpm_sendrecv_command(), so every
> command that reads a reply rejects a too-short response, and passes the
> caller's buffer size to tpm2_get_capability() so its copy cannot overrun for
> any capability. Patch 2 adds regression tests driving the GetCapability
> parser and the TPM1 OIAP helpers with truncated and over-long replies
> through the sandbox emulator.
>
> Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
>
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
> Changes in v5:
> - Count the TPM1 LoadKey2 minimum reply length from the header, like the
>    other commands, so it is 55 rather than 41. (Ilias Apalodimas)
> - Move the TPM2_PT_SANDBOX_* test-hook properties out of the common
>    tpm-v2.h into the sandbox TPM header drivers/tpm/sandbox_common.h.
>    (Ilias Apalodimas)
>
> Changes in v4:
> - tpm2_get_capability(): bound the copy by the caller's buffer size, passed
>    in as a new buf_size argument, instead of a prop_count-derived guess; this
>    covers every capability, not just the properties query. Document @buf_size
>    and @prop_count. (Simon Glass)
> - Add regression tests for the TPM1 OIAP tpm1_load_key2_oiap() and
>    tpm1_get_pub_key_oiap() length checks; enable CONFIG_TPM_AUTH_SESSIONS in
>    the sandbox config so they build. (Simon Glass)
>
> Changes in v3:
> - Rework per review: check the response length once in
>    tpm_sendrecv_command() instead of at each call site, so every command
>    that reads a reply is guarded. Drop the per-site lower-bound checks; keep
>    the GetCapability buffer bound.
> - Drop Miquel's Acked-by, as the fix changed substantially.
>
> Changes in v2:
> - Use my real name in the From and Signed-off-by (Miquel Raynal)
>
> ---
> Shahriyar Jalayeri (2):
>        tpm: bounds-check the device-reported response length
>        test: tpm: check malformed capability and OIAP responses are rejected
>
>   cmd/tpm-v2.c                   |  4 +-
>   configs/sandbox_defconfig      |  1 +
>   drivers/tpm/sandbox_common.h   | 10 +++++
>   drivers/tpm/tpm2_tis_sandbox.c | 28 +++++++++++++
>   drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
>   include/tpm-v2.h               |  5 ++-
>   lib/efi_loader/efi_tcg2.c      |  9 +++--
>   lib/tpm-common.c               | 16 ++++++--
>   lib/tpm-utils.h                |  6 ++-
>   lib/tpm-v1.c                   | 62 +++++++++++++++++------------
>   lib/tpm-v2.c                   | 60 ++++++++++++++++------------
>   lib/tpm_api.c                  |  4 +-
>   test/dm/tpm.c                  | 89 ++++++++++++++++++++++++++++++++++++++++++
>   13 files changed, 244 insertions(+), 59 deletions(-)
> ---
> base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
> change-id: 20260723-tpm-trunc-resp-664a3babf1cf
>
> Best regards,
> --
> Shahriyar Jalayeri <shahriyar@byteray.co.uk>
