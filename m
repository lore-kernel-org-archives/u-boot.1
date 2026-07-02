Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E7EC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 06:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B4184A26;
	Thu,  2 Jul 2026 08:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hyf8RxeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6CB884C15; Thu,  2 Jul 2026 08:17:11 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9934849FB
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 08:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6647bc8f900so1533416d50.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 23:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782973028; cv=none;
 d=google.com; s=arc-20260327;
 b=kiC4/qoK6Y9BqEJ/6CcmGaNy1biLmaviGifrxnnCSRmnu2OcFewPIN2P786kLigwBG
 Kmsy0wfM3bpVzDi1ao1GlijTEob/dMzwsCNbtpvE4iTSphAb0VuJxBvG9PbGstq8ZwR+
 QSkdSNaAHKMzFQB+SEHkcs+aPcfXRoUk3bG6YfhXOJvrjymC4CSQY/FEQAQT8AcpN0BW
 dVz4LugB4MRIzbDAcVKtZ4AvrGX4330dvxiu3vScr5yKxbiplVedCNOQJL6oklzL8CeQ
 F+hndl6KKuOjojNrBtmT60dBb+eAg6Wg2gsKplXxGxnhud0lBf0HrXMSZHDiHfvixlbp
 kxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ELul5n4ulzDxTVCOSbRhb4Eu8P1w7L3syB9xykWi/Sg=;
 fh=8xChkeoVVvPAsiI2wiiKyubZOgbDJUUKR3XN6f5wVeI=;
 b=YbBISHrGDo5FmCM3o5alLzZTAmZM7OjTOa3O3dIwY8WxSQQzvAf6dl6v41U+XjrEWi
 8zQezRTUNtqEJ1DetkT0x3yV+5ebSbBJ4R2QjQbrAkV3dcXJsOZyFb0mBOd03w6i4riT
 dSKnG53o7xckjNmGWG9BlQHTc5Pn9edlQMJtj5Ovuo2dLEvGXKvLSBPkdN45ExG473mU
 GpTVDD6p/8d+ogzELH99D7LiAt2l0ouOD9cviHL5jKcj90Ia4A0v795gabJU7Of2F+Xq
 hh1u2fMs+RXJZv2LJILe4oLqc0cbZimf66t6Xx9sFSLAjOQqJZ567WD8u4uGDRShKJCn
 ol0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782973028; x=1783577828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ELul5n4ulzDxTVCOSbRhb4Eu8P1w7L3syB9xykWi/Sg=;
 b=hyf8RxeEevg5HkZeLrOHroOXtd73uf6k3eNgWzqj36hjkxmoE9icDs6/gXz7OEJMHf
 L0Cp/FAGxiZJHfww1WVOfFTlkQb4fJfp/saHliW6/YwP8cw1+F12pgzw7zI/z0c2PFfs
 VV410t/cVPZMVgccl9J6HecGJ7Wcu/737y13nyvwj1uo/DExqKXPvcGYdJxJnXA8PtZN
 tWzubH1aoGy+rTFH8bNq9f1IFstREX2pifQJrwNtgtuImcBZTjVKN6Zezo5cMQzvqxts
 pad07dhLzBqe+N4VBzo6mEfU2Ta4ptSPSOjyEw+LujHtJZBsJICb9IEHYHMsZZ0JTmk0
 yfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782973028; x=1783577828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELul5n4ulzDxTVCOSbRhb4Eu8P1w7L3syB9xykWi/Sg=;
 b=UvoW6+Cdc6pIBQDiI8+z1S1zXlx2bi5XPpDmEkhIAVOsQVGRxFzZkbaYA5VuSOIqVK
 Hkx55L7agUza6FqKUsOrQHO7jNboV78Uf8iKBxw5pbMBwn6Wz3PBjj7Cf93oTAPkFclS
 3LN5GP+QoW4OcPRnlqTYfq/CtEAmzCRrQSioiEWjwt+zBfFeZc9hBF+ocUlr2oQXsWdM
 1gRezTaO7bRioohtBAujIfJdp5a+KYsaMW6DA0C+/D4MwJcNbWIRAD5PMPoTdGN5P2O2
 97a6qyW1JhQgCYNF81EVTSNH69c20HDD1wk+N+3UQiQzBe+hFwT0aUcyfiQwzAZ5vsPY
 pivw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTbdpLBkitvcQnL5a0uesHWZw/7KnuZLMRcFrU9LZXve4dBTJyEarDr6zqilSKje5o+yCZ7K8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx82DAKybQmeDTxkhZRkS6wuZVfmum8eV7I/2mvTg47WnsYMKOq
 80Myvkn2rvsz2wjaai3i+O77Nel4DXv0GvD1ztuupm/sUJXpj1j4dwnjb0JZVr5yTTgT3FFm7LO
 PWwd3kEfW6peToj3JMtB0RiK1GiRvNarJe11xOYkz7w==
X-Gm-Gg: AfdE7cllCW3G1DeagkP0b7DW814a/YKCKQs7jenO2YZJ7uW8Kh/33qeL9MmHgnIoFdE
 vqG/WmCsskF7w7dsOFuivf9psvq+H1BAG6K0X26j6I0gEPyxbfDjYWtg/pLEwLcQ2eyFSkdPs6L
 Wwf0qK41nLWFUfGRHsSCVNu0AuSD0KGB9po2i1P2dNqA3Yp0cKtWRWTvVYjMNEXU2U17XdoMQjW
 pmXPVmtqRB80JsuZ7gWWFrs93E/dnzGQEG1Y/4yZykV3cM7+fZGB+I0Zc6LhzzrTep5u2oRiyl9
 pQNGD8CvqhbNum1AqJ39KUWum4+6sWSbEDbSa9G6Ml0hTUeGmY3jzSfhRG8JJrYR8zpYDFeeBKo
 h/Y7rNOGh2PJzv1F2ER03VTI/fEgIePobcWoasdPne1gX2phnV6Gs+KEy74mMPQ54GTQDFd9XbQ
 UkSTv6YswQtZP3ocMS+OXjVX/IXrWDbDNEpV+y7n/mVvoVM40hPhCRAShmlF+lo765jrb+/KixX
 nClnRzs611Tw3FaPNmTVANzagVrJ96xEp6rhs+8gejSDlkqgcsydV2lKicY5sA89opp1h5jOFeL
 FMPLYTSeIEqzo+92/LYsMDOWUnPaASY+jSsZGY6x6pk0+RomkiZGat8mpEmp6SP7wb3l/o216Bp
 L2F127g==
X-Received: by 2002:a05:690e:134e:b0:664:e577:d1e0 with SMTP id
 956f58d0204a3-665219696f0mr4943727d50.14.1782973028370; Wed, 01 Jul 2026
 23:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 09:16:32 +0300
X-Gm-Features: AVVi8Cciu-ijTp8puiFU3OHBi3XJxyzLwydx_V73iPm-0SG2IHxD2RNgJ4Bks-4
Message-ID: <CAC_iWjLvrqeBr=EZ1Pkh_DWpZ8+xbBzp1Z_dq87p=HY5T1ydQQ@mail.gmail.com>
Subject: Re: [PATCH v1] configs: qualcomm: Add secure boot config fragment
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Aswin

On Wed, 1 Jul 2026 at 15:22, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Add a common configuration fragment for EFI Secure Boot and the
> required hash algorithm configs to reuse across Qualcomm boards.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  board/qualcomm/secure-boot.config | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 board/qualcomm/secure-boot.config
>
> diff --git a/board/qualcomm/secure-boot.config b/board/qualcomm/secure-boot.config
> new file mode 100644
> index 00000000000..21f567e1a45
> --- /dev/null
> +++ b/board/qualcomm/secure-boot.config
> @@ -0,0 +1,6 @@
> +# Enables EFI Secure Boot support
> +CONFIG_EFI_VARIABLES_PRESEED=y

Enabling this on it's own doesn't make too much sense since the
compilation will fail. What we could do is amend our EFI makefiles and
generate the file if it's not already there using tools/efivar.py

Cheers
/Ilias
> +CONFIG_EFI_SECURE_BOOT=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_SHA512=y
> +CONFIG_SHA384=y
> --
> 2.34.1
>
