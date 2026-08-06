Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCBDC5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24D4D4086A;
	Thu,  6 Aug 2026 21:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o6LDIdhwmQcS; Thu,  6 Aug 2026 21:04:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E754D40820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050254;
	bh=AaqedSLtpiGw7YipH6SdH9CLC8N8NgCGxS2Ikjdk3sE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fERmiXS31wTVGGvn+IOIfdXaiZreVrVK0kcDrBDcFK1mGxaAUT7CXGB3CZjI7GjKu
	 j9FAV0hEUBbmPyoxrItDp7eWIr67MBu1ZXUm/Wv9caccSEJ4gyKUmD8fU+TnmXRH6H
	 nGv1TKmp/r1A0UUU+3jo+Rp+oItCgGW6DdW87IvgI8vlp0hOb0GvYA0F+tK4AkPqIl
	 SOCqrFDMsOpHZBrlDpZ6gEWtAZ4UO4myLHOZ8Ss2EMJQDBcosNhUw1io67jrOT4Vtu
	 wv1cpem5epqI3nvwetL52O5unHeH08vg0oYGKvYr9sO31FOVcbKPGLOu2PaCFAahs6
	 4ab1YVnsZT0RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E754D40820;
	Thu,  6 Aug 2026 21:04:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 798CA218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B917607D8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pr21XMmCV5S7 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:04:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7ED30607D7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7ED30607D7
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7ED30607D7
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:04:11 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2022323c37so346547266b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050249; cv=none;
 d=google.com; s=arc-20260327;
 b=qTzym+Z4BW3yYsvwdEl/8gssTZpQe539qRsaRtl+mgvfmTDazJ/8tVrJw6k4wmVaUw
 SC0+FfPnEp9DXt/TUfbMxYryo796MR2/dRL4DU2YfYEOJNzHixV/nwVDq9/gxpnxG6Cn
 EOkvjUWLjRk267uX1L8UGbYVP5gCrn9XgaUYC2OZb+D773DHJFU57E3+Ik1Ntj09UKmp
 Z82dBRi1FDz0J/9LEwbUvttKl9OW625ZzLNh1AOCfqIudfKGcbhRcfpIyWDMhnz+3nHW
 q7v0K4339QalIW7632sIo2myDiFiqnzdXUu5R4KYEs2YiqA9nSK8WBT0Ikok/FhL+BhR
 ZF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AaqedSLtpiGw7YipH6SdH9CLC8N8NgCGxS2Ikjdk3sE=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=Dl6afoC+ADXCboTipbwONeSdekSwQmIVt2dbpV7yOd+w+fbfP8a15EET3K+SFs71SQ
 VUVKvgIH+msj/yNBH1Gqo3vBSXxv/kt4culOPFXwjcOqMPOqbE9M0YZ7Z3hBN1yADnI+
 ia07/dnTlOVF/diRpQqvdvqjbozM0iH0CAIGcZx6oA+4Ds3btbAJVjcAbV9y8aTvA/xK
 xSBC7vy9cjKRicP3QLfq/S/Z+lB8hSfImVgWQ+/ipz4dxL3WpUwgSODEZQJ/+JgJ14Xm
 pRHGBwPxP2kZh9nwanKArsTFQaZashVO6KNEYeG6AhnA8D+D0ondE1PnHEz0SlmFCkLM
 85Qw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050249; x=1786655049;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AaqedSLtpiGw7YipH6SdH9CLC8N8NgCGxS2Ikjdk3sE=;
 b=P/g0xr2RYCYkPhlkmvvTyLh+qHEOvsBd/+yEtZRhUlMv9Q4p1Drg0DcXcHsIi9Eg2a
 AdH+fD6rTFVanth5ur08Oxq4/T6YVCM/y7WCSy0yUaLY/U/JQqUf1En9orKZNYQSCxEG
 DiubodCWPl6MO1arxqwUxQen4arYuhH2bMup8fWkg4jTtiJK1d5XZM9OhaIJ1IgAvKoI
 ahHj6J3g1B3Nqi3cycJ3GE6qMM4W2aBvVK0ugDXQY42AJtizrLXe+dV3KhSiWS6Aq9E7
 iOX/VJ1ZIrP7RKfay0ug7/A+vdKjVmStpZk34uLkgtOaNrTuF061nZbro1FcX3q9CvJi
 CffQ==
X-Gm-Message-State: AOJu0YztHDUFpxLCWCIN/niGOWtJNASDCiLIdPkLthe0K2o9dILcZryO
 zFfNH0XABKEZ6Zyp4w1r2OIYUNsaYViwPSG7HOMBIR1ykYKxlvTIF1g2BfDj6fnbQo328SEp+2+
 7plALM/oQS1vjYuhNyoZndJjwqvvGBBio/ETriKG7
X-Gm-Gg: AR+sD10qDUOwIAc/4lNbx5Il6V47no6Co29iwRQUpyx2v+n9lM5OH0c8SozKxgXuPrs
 xU4Cig9XTlDH4HhEH0N3zzn1kfLHLwdk5YFeGAlzaGoVhxkjHjiN1NqBq7cPpUVIozEfsV96cxX
 1Hs7B+sQylQPeGSIbiIRJWrAvuJKE5Dey0pluMEJmgm85Yt+GTfuFYczxZxj/8EToMP+WbVT/Yc
 qa1nlutcp+SacRzaf/IdsfZeDwS2fBQwj6m8hkht01JfpZT4mxZpbuGmlNKrvefD50be1PnS4hG
 KKIUdph4hcaPtsFUK0De7pEZ9hBu9I7/GPUf45UT+nM=
X-Received: by 2002:a17:907:d29:b0:c1c:4895:c3ba with SMTP id
 a640c23a62f3a-c207339166emr213454266b.22.1786050249400; Thu, 06 Aug 2026
 14:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-2-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-2-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:03:55 -0600
X-Gm-Features: AUfX_my1KUo4JEyhluWHZ_w8jXAJikCEU--60RBj6X6jubXuur0fcjNr9B_cPeY
Message-ID: <CAFLszTg9pE70Ndph-NYNmL0D5CNf_YECQrQ_0K1SH6X15zxvug@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] tools: binman: extend ti_secure_rom to handle
 op-tee
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050249; x=1786655049;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AaqedSLtpiGw7YipH6SdH9CLC8N8NgCGxS2Ikjdk3sE=;
 b=UFnresnMI9ahDJ4sRpOuf/1Yu6Npb9NoDchnW/kQqE9EBSCLyqoN8gJQ3EfQheChlB
 7hrMJk8d4aGQBQ/u3O9VUrkcMeg3FFEI9QF8pvF1kbDRhzyy3fWELgxRGug8T7ZWy4N+
 gANLTZ6jpEkGgwgnQcD7XqLxpuLPE/32kC91Y=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=UFnresnM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> tools: binman: extend ti_secure_rom to handle op-tee

>
> Add an optional 'tee' entry to the x509 certificate template to include
> optee during the second (tispl) boot phase for the AM62L.

The commit message is terse for a change that adds a new component
slot to the ROM cert format. Please expand it to explain why the
existing dm-data slot cannot be reused, which SoCs need this, and the
meaning of the compType/bootCore values chosen.

>
> Add an optional 'tee' entry to the x509 certificate template to include
> optee during the second (tispl) boot phase for the AM62L.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> tools/binman/btool/openssl.py                      | 11 ++++---
>  tools/binman/etype/ti_secure_rom.py                | 34 +++++++++++++++++++++-
>  tools/binman/etype/x509_cert.py                    |  4 +++
>  .../binman/test/vendor/ti_secure_rom_combined.dts  |  1 +
>  4 files changed, 45 insertions(+), 5 deletions(-)

> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> @@ -80,6 +82,11 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>              self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
>              if self.dm_data:
>                  self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
> +
> +        self.tee = fdt_util.GetBool(self._node, 'content-tee', False)
> +        if self.tee:
> +            self.load_addr_tee = fdt_util.GetInt(self._node, 'load-tee', 0x00000000)
> +

This block sits outside the 'if self.combined:' guard even though tee
is only consumed by CombinedGetCertificate() - please move it inside
for consistency with sysfw_inner_cert and dm_data.

Second, the enable-trigger is inconsistent: sysfw-inner-cert and
dm-data each have a dedicated boolean property in the DT (see the test
dts), whereas here you overload the presence of 'content-tee' via
GetBool(). Please add a matching 'tee;' boolean so the DT schema
follows the same pattern, and drop the 'content-tee' bool test.

> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> @@ -219,7 +226,32 @@ compSize = INTEGER:{imagesize_dm_data}
> +            self.tee_ext_boot_block = f"""[tee]
> +compType = INTEGER:17
> +bootCore = INTEGER:16
> +compOpts = INTEGER:0
> +destAddr = FORMAT:HEX,OCT:{self.load_addr_tee:08x}
> +compSize = INTEGER:{imagesize_tee}
> +shaType  = OID:{self.sha_type}
> +shaValue = FORMAT:HEX,OCT:{hashval_tee}"""

Just to check - compType 17 and bootCore 16 are the same values used
for dm-data - is that really correct for OP-TEE, which typically runs
on the secure A53 rather than a DM core? A brief note in the commit
message (or a pointer to the TI ROM spec) would help future readers.

> diff --git a/tools/binman/test/vendor/ti_secure_rom_combined.dts b/tools/binman/test/vendor/ti_secure_rom_combined.dts
> @@ -14,6 +14,7 @@
>                       content-sysfw-data = <&unsecure_binary>;
>                       content-sysfw-inner-cert = <&unsecure_binary>;
>                       content-dm-data = <&unsecure_binary>;
> +                     content-tee = <&unsecure_binary>;
>                       combined;
>                       sysfw-inner-cert;
>                       dm-data;

If you add a dedicated 'tee;' boolean per the comment above, please
also add it here so the new branch is exercised by
testPackTiSecureROMCombined. Worth adding an explicit 'load-tee'
property too, to cover the non-default load-address path.

Regards,
Simon
