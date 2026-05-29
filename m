Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004E1CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01C2846F4;
	Fri, 29 May 2026 11:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H3NmwLn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF860846F8; Fri, 29 May 2026 11:57:28 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDC0846E6
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bdbcc6c4500so1301445866b.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048646; cv=none;
 d=google.com; s=arc-20240605;
 b=VG3b+gEWUSemN0Oyx8+m0ZyfE63foIRrxKFAitwy/6bepkILuPzXd297BpkJTQMjlO
 LysPqUrmfwQYu9tn5qYALp5LRwCF7EngoWsMbn33YpBwHb6oEpNcAFJwQ9hH7T+4EUVt
 HEkDCuXDhsIJiqW8rsX2Fwwf3qqOJan7pvjHuLMB+q6v4JUfQ38w89zdwbsZLAN5GDHY
 TM2fXwYkkPPIVeb0HyoJ5sLIPCQLoXPvOQfinQsgMEl4dnoOvui38nx5Z/j8DZ+a9Rth
 u9y1/OpkRgOp0/526zYAyJUgcLKGQOzvLn5vvKxAX7omYWBce6OgF9eUAaaEql2KnbIM
 4p5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f24cvLGmQpG9uFUX2/9WJFN1a8kCe0KHaKgMwgRriWg=;
 fh=Pwed0uR+fUcTESmvhLrbsa6n1RHCX2s8IPfo/JJetiI=;
 b=gFszdid2IaJ3g5epg2cWA/sSY+qdHHZ0NjwAbMdos3bclnjzcqZTLKgIjRh6FIhPEU
 Pj65XkY4v9O5JFuH4bXDUDamqMRGinDl3z/EFkywRu0gtDjevQ4dvXAnOSgrIBDpK3gB
 dBYMnzPJ9OlW0BJnhw40Y7PeuFFyzm6LDjoMEKHiLTGcRVIqGnhuf0pDBHJHGcXv/OmJ
 o7D0b7g5FcTaNMjb4mDu41OeQlllXO6+VrKB5LOyYK4gi+pRsVnmyJbYSpw6p8UX3BC9
 ANqil8Weu5kMWR1oB1wblkGj3rU6hqBYjaROseaUay6rS94S/gHEeF2jR8Pva6wtFpUo
 1o+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048646; x=1780653446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f24cvLGmQpG9uFUX2/9WJFN1a8kCe0KHaKgMwgRriWg=;
 b=H3NmwLn4SUKlFT/39pzkuNGkVB1hCPxSjBX/Rnkj+u7EX9lJO4dS1r4LlwP9TtEgE/
 IgucnR9zjrBH8JW7ECxxKRSONdxbG5nAd7HCkROBc26j9O1KedgZcshc5jRnIt8MHaLM
 fKU+jpTKpVQrocflqV6Z/NU1jAsGiRzsaDQ5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048646; x=1780653446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f24cvLGmQpG9uFUX2/9WJFN1a8kCe0KHaKgMwgRriWg=;
 b=cyfw23ndHeEX8fy3t48V80USNFOZ+VVQAXcbVj1pW9KrURQQSxuwyt1JAXzD2+bARP
 hEDrT2keUWYYNdDJrz4cS5ctHzDUCCLBLQwMQ6zaWeGL4glEKItPsLrC0Xrjpa6OKaQF
 MKgYeQ0JsedHDORuh+EW0o6D15wdVw1lGVi4ItgI0zi7zEX+IPNCQQzXI+0nhNvbBREe
 PVaKAP6BgazpzbONUhm0O3MO/3j2oE20fN7PJxACq9xq2AzB4DFDzUDEr3PnPMbWJygS
 vLSUyGmwmwCuH82Rrv8D1qOtcnFwEZBTAATDfmGjLOlesFKipCwQ3MOsrHt082I3oqdG
 AIwA==
X-Gm-Message-State: AOJu0YyhJis6gaeT9nUv0fjIumLS0MyGA7DoSk8qR+/ijGiwJTBpiII3
 +ii8FpynJBpHQz2BVHpNcgrJkF4ID3zweLF/FXO1+BCpEtJlLsUEZlXBGH4PkFhrVwSsYYVqNge
 3aYyNMrmanaykFSy1VuIrLhmIDC3h5aYWO4bUpWQU
X-Gm-Gg: Acq92OF3K8ftl7ROzid5kqvBfI+zla84WemoK4gAOAeSncrYJIARHn3jbGQnVhnk2ZK
 qei76bpxRryJzWM4OVzYC2dLnGjSkveqwenTKbIjkD5JUJ2UmXD2IIBRBWBpRF7f04IZPoDa/4M
 XEmQdgGXPyrMIn4YFS1wD5ffg7qnMZqQzJ7S4r6XpYjaWlInFl7iRUvZK+7oOBPNr5PRBQlDlkU
 ci2sSZe/1SJMkoyRhztnlYWJkF3i7+6xqt9+1brTX2Tj5JrCNHlgBZ33p2raupe/gAh3N3nmtwQ
 aqnJy5Spvs7/Chl2CSNBKokW/148Fg==
X-Received: by 2002:a17:906:8468:b0:be2:d66:eb21 with SMTP id
 a640c23a62f3a-be9cbcc413fmr94941566b.26.1780048646448; Fri, 29 May 2026
 02:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-4-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:57:09 -0500
X-Gm-Features: AVHnY4Lvkn1vtmke_DLaJTdUIIzWivLmyOjymUe2XUWu6rtB8UdWWqUV2qzOvdk
Message-ID: <CAFLszTi9f77sDob8fZg+skx6X2AiJydP=T-rpG=kGsc_dRQuKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drivers: nvme: Implement flush command
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, sjg@chromium.org, 
 trini@konsulko.com
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

kOn 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:
> drivers: nvme: Implement flush command
>
> Implement the NVM flush command (opcode 0x00) to allow callers to
> synchronize any buffered data with the backing NVMe storage.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/nvme/nvme.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
