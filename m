Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E509BCC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 22:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABB22406FB;
	Tue, 13 Oct 2026 22:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DDLPSqnqgClB; Tue, 13 Oct 2026 22:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC87640709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791928874;
	b=i0SinvA1UClqgTozs6zSxfLYPzS3TtxyoRVfSo6KucTjavfFpGidyE9oQRPfmALoMqv1
	 IkUO1gKACe32AREhwkDANs42SdX1FkVMrKTF3FanQJwplr6p5sy0b++7Fo4pgubicQFk5
	 WlkF4GtSAt6ulrO5goso0KtBwDOema5PUfJGarZhQrOQX/Ers1V4OtMT6tOzjcBgV6NT9
	 yTGZuvzKJmfsqgVSaLb/4q8B5P+J3ubAHf64wzdqKHhIiS9IitN/E5Xf4LeB14q/YHkxA
	 WEs34OvTU8azwmALUvgZiWHNG3R4aGfqGl094snhPPKMeDKLFUL9F74RSUfquLTdYNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791928874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2K3AptX3sanO7VxZkkZgw3FXE3NK9UcZO2o9+oWc6Ps=;
	b=d2tECGoNhEo4gJ6p5HBthuQNgnJ+fCw+oJKgap7q2U6DiYYvir3Ng1R9Uzy3N5j71ssp
	 Gjm6KgmFzkHEwZoiXqgpYdrd5blO62ktwXnNFIs0HWOF2cd1ZwV+3fem4wuVnVcDOGpeD
	 iszoVUF48sBQ8WmFJ9y8AtdCC979JfMf7cTUN+IwgZUHxzhHEgVZmta3Z11zZGgWIlQu1
	 4V5s8/yxY+fweK9wFc2Lj5uWWk0x2LQToqDGKzCK4D7MNPv5ScQM2owTfW3TlVfA2Nebs
	 Iieir/POg4YlrRmwhHdzcRn0qDTJGV9Tjt9KLWMVeXIqndWJ8USaJkFGuOm7Wym4k7Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791928874;
	bh=2K3AptX3sanO7VxZkkZgw3FXE3NK9UcZO2o9+oWc6Ps=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZiT5rJ06Z/MrrbTe+CQTXvVzszczLf+TM0aSHD0Snwf2yfY3IB4g306OZ+89noEnF
	 Sm7d/Dvkjw9ZPicCl0ZGIIh/UOQbSwkgaNNZ1X8OmQ4QlKi0wGQqUlc+FJFiOwdQzi
	 LH8WZsKP69SUjA14ABIKWuN1BngSKxTzvzigCNHhRLcoRnJmZ1UG/WDVFXXWA4cESe
	 dVEungZOa/EjdjslrLFuQf4n1K0S9alJThSq6AzsymRzUjuBws7hsS1wCPjpKGbR2+
	 WY/l07DwvQ09pp4TXSnq76/yjq04TrIrthudPv9hXbjn5lrbZhMTHYLtM1k64758m/
	 2ATkomaX0/Abw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC87640709;
	Tue, 13 Oct 2026 22:01:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE8582AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC4D58081F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKVQPtU-QQLE for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 22:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28CE0807F9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791928871;
 b=hMsOGjHX3Jny3SKmKWxN6j5/Pkw4gOOBDafl3vgcTuME/eqTGdhA5NARyw15m0sKLWSg
 1pgBMMuluexrcQSX1/M0g9V5ykj1N+gKr+1kvKdHYexnt7MWkFrKkR+RNpqa7Zozwr5zO
 ekPn+bPi0xvVAQDyi78DLPN+M34bftS0melhbXN+mS97exYZ9rHb+jDnk8P7Y0GPxA/yY
 Dp5vjkXcnWN/m/EgznTsgjXPn9lK2YbuJq1WKmUSMRZ3km7nDMNAHQE7BZMh0/QUX0RMw
 ppzlejE4R/h4h5pb2Yyv29+51Dl9qhCF41/tN4Fdo7nh5614LfutpShDYIxUbQIpV6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791928871;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2K3AptX3sanO7VxZkkZgw3FXE3NK9UcZO2o9+oWc6Ps=;
 b=BBiRnP1ykZSzjE6dSqIrCe/RTl45XF8OXor2HMOa4lFdCfbnCDPncBYyoT1Ijezv6u/3
 T7FeUScnsDze4p24qYydY5dqBi9IiJrbsXjtFfLLmAzaxMSnc3XrbUkI6C3fMcn+kJKVf
 k6ROt9H50BYDKhQMRlYYzXX2cvg6CZ+c9ijQM3NM/C65nqzqPQIspEE4dnnjcF7XF9PtU
 /WOf6XOWMq7Q7YUQxPwiRU4PzY6Ixi1EDhyOrMQ9iPuMBeU5tNe0aW1VCgbWmo0njjYik
 BVF68CAaNQvfKotW2vS4mjfcO1m6JZ+WOWHM5BK/jjBCa3Pc7YxlNHWvycBbnSOJUcw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SYk0NU5X; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=SYk0NU5X
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28CE0807F9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 22:01:10 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-825487fb37bso2163959a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791928869; x=1792533669;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2K3AptX3sanO7VxZkkZgw3FXE3NK9UcZO2o9+oWc6Ps=;
 b=SYk0NU5XYETbKwLa56kBOzUayC2I6FsFsDZBtgnIYMB0Zc+UCiE84i3YMhsOtaM7ms
 B+LzTaxaqtEzJ+Qd2gUTWW7wv4JFTjMeKSxuLYdVM0m9fWyqAu9O0lWU4KL7BMkXdLsV
 i7GC2PyCBUGYqD5DDxGvlcI5FnbeNqf781ApxnDlSY7zZOudwgyjI7xxaKM698iha0Cn
 iOuF+gnex2QzwayXc/LhJYbNTqLK1bFQNB62eMdMph7VvsakDNvi8gO8l5QwkYvHU/xM
 yoezDWCAzJMMCaosaBrJoiO3t/9i3qCti4tnluqFsG0B4rrngQf/nCASpp+JTykLdOk4
 MYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928869; x=1792533669;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2K3AptX3sanO7VxZkkZgw3FXE3NK9UcZO2o9+oWc6Ps=;
 b=onI+a1vXWbSSCTfAHqXQ566dUIW2Ciuvuy6pyBaIOwGkyOhL4z05qI45rtrf/372iw
 2AHs1DCHWLNuib/ofrYmE8eeAm/WADMe80UTxWyftCeUXWoFGeuBypV8ALIQwMmshomy
 mfjBUf9TA4wslTkIg/j4MSBmDv/K6vG1ZV7Cr76ptZe1pf34dttJkmmOELnPQKt8aPWp
 Zt3/YpWd7t+3n4ELBufSgJ3976IwEHGRVDxx+Gbl+PRC2VuzBw8CNZjooDZVTUihL6s+
 lBS5iH0AbAOFv/POIZG4Cg8QumHj3oQWfqNzyvgtOGajTpwKXIGSJHXDmCR0/2kbBktr
 6T3A==
X-Gm-Message-State: AFq9FYKduFpt2Uh10WdB06ITVcGxKcOlUeVRfreV/vzKV5sfuCxGS12f
 zKDG3ephcfavpOjw/4A+0AAlXxYHxl0UPtCDVQactEYDZ/u1IATcnSwqspS1TXskUwGZNHoRcCS
 4m1Ke
X-Gm-Gg: AYBFou1WQsp2T4cIvKYTrFdq0Fl8QvbRkz+UWaoEnXb0hb3TizyzVAVoca6sFkgNy3S
 27Dr0ID01PIUuu4vet2ljs7UGOIkR9tnai/iH3jY39WyFYPjXrtaZ0gCWQb6nRDWMfxoyk/MQNJ
 dJXUqPqaOsIkk8LwuN+ztKXDwytw+cqqjww2jIPDFsX5DmdNkkxHRh8Pqg/o+mDTiG5hse803oQ
 8IRQ5UAXLAEPl6HirsNR3i66MKlnDSaOLLZOjkEtsPEBzlebIrFMi//liIjXFQog53bXwPBthbB
 NHlFJM0KldULIP3vs7zBlEc2PjU4V7nnBxnOBVvsK15T7sDh9dXX1fQmAMyA3ez9TF2JYt+zXaF
 ujiLEvDta+T8ZaUhnWdsPxuZ3xXICwkZnwuB9domrqBFtiKWML1TzlaXU19m3n/fKTc3ybkkmaY
 rMEMWP5RE86p9O1PKBVuPIuk6ePCn0eziiDZgEdKvLz4p8cDkCO/i7r9qTj6WsiOo93kAK73N0D
 jg=
X-Received: by 2002:a05:6830:270d:b0:80c:d34f:5f63 with SMTP id
 46e09a7af769-8309814be28mr12795833a34.28.1791928869412; 
 Tue, 13 Oct 2026 15:01:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fc57:1703:6147:d976])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3dfa1sm13553348a34.18.2026.10.13.15.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:01:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] boot: image-fdt: fix reservation errors above ram_top
Date: Tue, 13 Oct 2026 17:00:38 -0500
Message-Id: <20261013-image-fdt-above-ram-top-v1-0-f7db4b36d464@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqEMBBF0a1IjS0wkVZxK+Ign4pdDRpJogji3
 jvq8Dx494RIgSlCX5wQaOfIfskQZQHmq5aJkG02yEo2ohI18qzy6GxCpf1OGNSMya8oSJu2dd1
 HWgf5vQZyfDzlYXwdN/0jk+4cXNcfb2PgoXsAAAA=
X-Change-ID: 20261013-image-fdt-above-ram-top-1ebc77f852df
To: Tom Rini <trini@konsulko.com>, Randolph Sapp <rs@ti.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QaY2cP9OUJ+VxnnojrelYo4o1VL+47AJSXl173WGXJc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqzqoM4PZO0QMqTOEcCZ7L8HSev9DVT3CvLAPmS
 vBwZ6mF3WCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCas6qDBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuycH/j2hmbEEkbqPAcP7reB/L+/WJFmjxn38wcJ/tRQ
 3u6LZjNhocHGZiw25j/KCQWis5PPSu50lt0j91adZ/hzqhOqpJUKfcHXVeUhb7qxpT+Tcv43gTn
 YKP/jNpodYE0U4Sa0dmYFwLuWuqu78FmDT+/mYHhkF92BnF+w2sAg6Rr67q+HX9lc1sxejG5jTj
 sK1Gx0Glq+lX/yHr7ifOUtvg2BTET7qSjITTMQQeSJBrxeqVl00QmaRWr90Biaos5Jw56Ftw3LO
 Yqt7Ng/5Hded8XXZyCl3tCVIErMF4kNoiZw0qcBLqh4B8yXjpzAQ85Jby6lRvKviC+T9CTUt1pC
 Nd4Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

With LMB_LIMIT_DMA_BELOW_RAM_TOP, LMB reserves the memory above ram_top
itself, so reserving a reserved-memory region there fails with -EEXIST
and prints an error on every boot. A region that crosses ram_top fails
the same way and leaves its lower part unreserved.

For example, on the MediaTek Genio 520 EVK, ram_top is limited to 4 GiB
(MMC_MTK implies LMB_LIMIT_DMA_BELOW_RAM_TOP) and DRAM initialization
reserves a page at the top of the second rank, which is above 4 GiB:

  ERROR: reserving fdt memory region failed (addr=13ffff000 size=1000 flags=2): -17

Patch 1 skips the part above ram_top. Patch 2 adds a sandbox test, which
needs LMB_LIMIT_DMA_BELOW_RAM_TOP enabled on sandbox.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      boot: image-fdt: skip reserved memory above ram_top
      test: boot: image_fdt: test reservations above ram_top

 boot/image-fdt.c      | 21 +++++++++++++++
 lib/Kconfig           |  1 +
 test/boot/image_fdt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
---
base-commit: 03e0ee96b1cf21a20def03c079ca05427ebff208
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261013-image-fdt-above-ram-top-1ebc77f852df

Best regards,
--  
David Lechner <dlechner@baylibre.com>

