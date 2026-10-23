Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B310606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xmtUhZhZ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dBkQkM58
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E90081423;
	Fri, 23 Oct 2026 14:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_7LtETmal_s; Fri, 23 Oct 2026 14:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F32881361
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767338;
	b=IC8h9E+eMuEYqq64mY3x7g3ydYN/873YLQ8YdB0OUl/svGVVztfTvebIyyEfmJdiac3H
	 3ovo36WPzQ/Tjbmun+dTadxeLTve3dEfxvoSgnGhiIpaaBSe5zQxtth1zhxnB3idkRFeb
	 3MlO7jyeUVdhqJssMBa7qHA6JAZOE0JSK3iAa1/ehb70Q7FJ3hTs3pWmv+63RhPOLY/oV
	 1AEDbJqAyTG23pU0UMSHKX+unBz4opeT4HcybdgTOOxweQvITcGFPjHlAEh8E13pXdMDm
	 WfEYR8ZxQMp5hFofEho3KC/7YdvrkjDy37xNv8hGYpEjX7NYZatlTg9MsjdpUfOXTeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ySrMCFmaUvDu/0SsDGEmQnCjf+tofxlWX5QwCCRFI9w=;
	b=heYzyXwl+IpukvwNFe/Nsu/4tDkKKavAmz2WCEJKVYmRjsaXCmrxY/fwNYnkyd7eLmx6
	 NsgidL+eautboWZyaq6h2psYq3iDztjBTV9DDGc5ksq5S4Oog3T6ciDE6jh6VSc2N0NGo
	 2WFuqv6IVcrkXutv239l3ZuzvtCqSy0UNmk+Kl2m7FP56ZybuM4Sy85KbKaxhdYoKpoFO
	 dXDPUAbL7mNNPj/71/Z83QyXSxlMOhpZgdlu5n2JhnJ8x+FMl13le3ZcXbeWbUcJAc38x
	 KrbZAw9Uyfaqwjello2e653dxY5+VXGwSl+OxojlxdDUiJLSALH/JsS+ToYg3XK0RWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767338;
	bh=ySrMCFmaUvDu/0SsDGEmQnCjf+tofxlWX5QwCCRFI9w=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xmtUhZhZP03Ppxgot7bpSEjSXmMjxOb7SJ0YqXnadutDsVuI0O6zyQKb/LfFynkhz
	 of1920jNg7mut2P6cjitBl3ba39S0Gs4bu4Z3eb5sWAbyJU/rqTEfwgBgM4LsTO5Xu
	 MnjeCNQg+4RGLotJWk4EfFCH/H6S27Hki6zLvgekKoA2SPvO2GqW6s5FgqvY4JBDOS
	 N2Cqfc9/q5nsKroLtuVMYwwAmzlQ93nFXdM0YIGC2bhzHwV2lEMWoY+aze6rurc754
	 F2oy0E+NT1kJAsSIwK5t0hHUHVNVBdxqV2dhJvPWFpou94WqF3C7kPLRBUXm+J4EQc
	 3MWpvrqQQ24eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F32881361;
	Fri, 23 Oct 2026 14:55:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D85D12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E6AA40900
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6e-jGjGG2rUy for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:22:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2949040921
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792761760;
 b=VIth4Rxoh945XRsjIp4oHuM5tgp23rFj3UGSBTlxtXlKgHlJ7n2ewFNOfDJjSX0K/aDQ
 y6oEQGbjisK4Jup3K4ULhr4tGslCaYBsKJmcBevLAkygbFh4IC8bNpjbaizWa37wdGN8A
 w19S1mskAq+tcyrMbr8vk0BF8UQebW8PecMj21+EWYVC33e1QRqckHWtysYN1aqp/4iCO
 iiZCxU4JhGLBzfgoY5m7YDtZTLSdp1dd+T9c7988cjBAb/SP2wysVDu4LdOfKFc8u1pO0
 8OFVtNCEFaB59DZJOGqocwVoQF/B/ApNJdLJZQhCBGeZeSpu9DCngFq7eb6J5a1vK4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761760;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=ySrMCFmaUvDu/0SsDGEmQnCjf+tofxlWX5QwCCRFI9w=;
 b=RzBysbec9Xz9PMhdJ2c6DwZpDN3ADW7z1QjxezohzkCag/08ejxbzVK6pTU8owTMBrCB
 uj0JNpi/lL7M/gELjdqpNvp3lbUGpcFmBeZfhERenInZGJWPsVyFobUwaF19YaTYGF2u4
 B2shfVYqhKl7/NfM8EEoNqmcbpRus7oa8Iv39eufK5AkpGZBFWY1lgqKU5PZ7im1icxLg
 ZdPCM1ib30z9gpGXH9Lddud1fGmcyYUvAC9lhlWLvWc10mLsPkl7xP7Jz2MG/1dZP7FQs
 9+H7UwH7PljO5rSDqBy9xkZnqgyTWejTxfOPW7dwEih9S9yRGQtND0qq2y/Q0AjNxZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=dBkQkM58; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2e; helo=mail-vk1-xa2e.google.com;
 envelope-from=rnunez@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dBkQkM58
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2949040921
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:39 +0000 (UTC)
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5eac9db5905so306531e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792761758; x=1793366558;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ySrMCFmaUvDu/0SsDGEmQnCjf+tofxlWX5QwCCRFI9w=;
 b=dBkQkM58Bx4gj0Nx/KYvcEYfs5AiIMWhlA4urYrFTZrh9NPsvMTiZb55+pxfkOY01o
 TX03EGdTTxA5QOAKvSbWU5zSPj8A0XXeM6rt4XUxIS0VV0canMwYkUSWwWfKvx6ifVFm
 AzK6cBya7QQEK3Br3dtW9xY+Z/UNkzz44YXZWKFN6KCfT58lo0EHbPRcklP2/aAfW1EO
 jbJMePDQwBG73fKGDNXKPRfR4WIImsNx8tW5TEDcIP6Ltmm1wdKxbNadrEEEBiMty2dM
 8dgzbyE+EdGW3/VusvES7pVX7bMEYoHHZmz4o8ajUWr/hpa+tUIVtKxPjcY4LeVpu/XZ
 rhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761758; x=1793366558;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ySrMCFmaUvDu/0SsDGEmQnCjf+tofxlWX5QwCCRFI9w=;
 b=RIDoAslbNCeKMcnLDkR44SJwsRyHuE+0ykOix08vyjPHZaKH+nxCc8/GZutKstduvQ
 DLMu/T1E9tGASxWeVQ2XinBMRadVT1oaPc/0WYm2SSn9186d3bpkAfv57+oAs90VcWKU
 rywwJWpAL2PvEzkr57I/jxgO36twvgwjSyNPYak8jnTyeWIos8tyP4o/jRk0Zw9cxh8H
 VkFVR/dN4TMGPpMsw5Xi+ZYniW8l/X19RXCP+nby9xN3uKTvK+cWujBW+1bCw3PbZ+la
 qj9pjMXfEYB/+PGEaDRZoZYMmirNT1Mi/xDO8TFkSCB7p+ieu/NxOrS6WlWGKyIolOCp
 pQow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfeJwUoSYB5f72RJSd0I4DeFPN6Axp5zctEitmHBsMq1eCxSJPcpXYXEtfSnalu+gv22ifqQY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLlInhd+NOaHM5WAOhc27RoPK396znP1o5rNVl4hRoaZNZE4oub
 yKLspQvzVusi2NQKE8uabp2lhn5iozbQOForeAk2dRbthzGz9Ou17Rc4kOHdCMQG7Io=
X-Gm-Gg: AYBFou2W+nzTqZCNsWn9Updtgl6qAR+0rQFpa9Op1sNjutFOPSP7ZzRJP5kEulaN1S5
 IJ4QXryLXdO/0ytT1P15sNQ07aMlnb1JjC0og/DC3ukeHskcz0Fa6PvOEXfPpDyPQX6QRN67CJu
 yrgydG5yr+S9frSQHeGi+8oZfEzkR6zNit5QL0lGowRAMzOgXP+cYEsHXQfgHEKEAUlHS3EU3rK
 TVqYu+K9Kr/Q6Hg+q5QABxH2oYRpb6UpsGDyPUkd4n55JsrXfvJo97TcxGQufzPE6Fu+8yH/kJK
 HVZkK9zG7pxAI7WLR6orwKQn+4brVVAHM2vM8eciYwftsP2D/KAF/Wpq0tOyv/6oEo4wtHGbQKu
 KkKyneOMR+ANG+/gbSzyq9AQQKxEhIL7nhjuODDdr1OYQg2nRbLjK8/MpjI21uA96Alieg62Hrd
 LR7DG2Mj5irFsVVfaEvKG0qqLCny3WiIE5HulCwFSRx104ZzQfK1tlUL3HBgqqubAj9TPHvwERj
 psppZFhYgJlmoUwlhnvk70nkiEXUmaBwUdAcufw2Kz/B1otYzXkag==
X-Received: by 2002:a05:6122:8b14:b0:5c9:a60b:e5b8 with SMTP id
 71dfb90a1353d-5ec14b06b38mr816296e0c.17.1792761754041; 
 Fri, 23 Oct 2026 06:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([2804:7f0:7541:cdb4:5471:ddc9:4fc9:2])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec1fd11d42sm90891e0c.2.2026.10.23.06.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:22:33 -0700 (PDT)
From: Ronaldo Nunez <rnunez@baylibre.com>
Subject: [PATCH 0/2] imx: mx6: add ELF firmware support to bootaux
Date: Fri, 23 Oct 2026 10:21:56 -0300
Message-Id: <20261023-imx6sx-elf-support-v1-0-73e378c6d5e9@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRf22oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyMj3czcCrPiCt3UnDTd4tKCgvyiEl0DI3OzNGMDAwsz8xQloMaCotS
 0zAqwodGxtbUAtvYgaGQAAAA=
X-Change-ID: 20261022-imx6sx-elf-support-0276f300867d
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ronaldo Nunez <rnunez@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 23 Oct 2026 14:55:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i.MX6SoloX is an SoC with Asymmetric Multi-Processing support, with
Cortex-A9 and Cortex-M4 cores mounted on the same package. Both share
the same physical memory but expose different address maps seen from
each core, what demands some translation mechanism when, e.g., loading
ELF firmware from Cortex-A9 into Cortex-M4 through bootaux command.

The translation mechanism was introduced by commit c0f037f6a2ae
("mach-imx: bootaux: elf firmware support") for the i.MX7D SoC. i.MX7D
and i.MX6SoloX share the same memory translation logic, demanding
only the implementation of the translation table for the i.MX6SoloX,
what's done by the first patch.

The second patch rewords the comment about supported firmware
formats by bootaux command and adds a mention to the ELF format support.

Tested on Udoo Neo Extended.

Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
---
Ronaldo Nunez (2):
      mx6: implement memory translation table
      imx: bootaux: clarify comment on firmware support

 arch/arm/mach-imx/imx_bootaux.c | 17 +++++++++++------
 arch/arm/mach-imx/mx6/soc.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)
---
base-commit: acc808479730e13e74199119eb9b2b9113999244
change-id: 20261022-imx6sx-elf-support-0276f300867d

Best regards,
-- 
Ronaldo Nunez <rnunez@baylibre.com>

