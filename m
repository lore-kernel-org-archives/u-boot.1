Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D4606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JRKY33vD;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VsrRUMcH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D128E40AFF;
	Sat, 24 Oct 2026 00:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NVoD8cwZRt7k; Sat, 24 Oct 2026 00:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F249940B03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800624;
	b=nIRbcWqm6uRCC39lENtbThkoyXoXUbiI6w2iPRMxfrB36nJkfLUX03mDXP9QNKhiwH15
	 CSnksbulU+tEUo7HWq89Rn/CH5GrLSZXH8JpBgIsI1KvTAH5LcMBh7hgiIU7DPHnxMGHW
	 4mba03l0dNvK4p+jhJKqnkf3R3b47KU0qgKan8K61JHvJ/caFiAj5lbbmECS/zbqQcccE
	 3A91Lp1Om+EgWP6elnBFLWpnr0qShNGKVhTy5WWuxVOQwig41LmPhlTjNIZXA9kPmxSq2
	 PHjD2AV84+cR34obYiKBatL4NLEWD4NibgLzqHoRbopaeDNZ/YBf9CZfSs+zlpAj41A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sldUvXZX8S3sLcJDVWd+JDxISELdgBEYfoYn5Qa90w8=;
	b=E1w9J4Qw57oXovH5nE6RviRsQS18aFnMG9Aow7mLRuKElJzSy2NZlvyqBCxUATtiSKXN
	 Wbam0lk7GMnuNBu1ULXCF+tI+x3bxfTp6skO2gtaD90YcPXuBMr5HvZ/UsHIsjiYwo2kU
	 0ZbTBABDFCkpWt2JvTWSUINddyYgs2JbCTZx1WaqUw4BadSj1+dd98+uiFEhz/amUmPfQ
	 ksOmTABdjUbDBehioVRPJOpUW7hCn9y0aEa6gR5nYJEvOTChuYe4tW0J0FJJkK/JlB0FZ
	 kFYnYyPPiwpm1csrHdLSiRvJGwpFDNmI9IEd7i16Zb697aU8ndTBfSVpsI29nVDT85A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800624;
	bh=sldUvXZX8S3sLcJDVWd+JDxISELdgBEYfoYn5Qa90w8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JRKY33vDo2ZP8TtLjRl7lLnQBOjrhOGEAhx9rXkunXbovnavxCeDwohFkmhvG+pfE
	 Y8ryj0GYwmw4yP9IhwXVOXDtWMplokqBzJJzLKMo6pxGs+Hyg8C1sjhQSKjfHYnFuw
	 IHWYMNSoCMvnmgS4pXCS9nsnmYAokjupAVw+JjJm+DUjjg36eaBgAOcW3BnhLFlEJ5
	 aLyIItoS3wWyQGRm7tVMeAJ784lQdzM+KK4iCowtYYgW6DpalmcDRnZLYTn5soHfHs
	 ZKmqBsLJi4GHfROVrgWTdQx57F+FfjGrLsq3ts6NSkpyMQeklePWYSsTJCosQh4wMx
	 FpEOo453FWjBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F249940B03;
	Sat, 24 Oct 2026 00:10:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 510D33D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 370A380C79
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbprT4bF2kPy for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7211580C8B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800619;
 b=heYsWgZfReGFkGHPbzgpM68EdSo78lW6JcaudnazJRnCM9IkWJjzUwU4erm19xR4JJu7
 f4jObIMsyTUNOT415S9siBVRBi/yZzYGN+Wkxym12JoaV5Xr+h8dCgjwJXbZibsfwU+6s
 HvuX0+Hig1zy6wA5dunZL84wLLWIBaVFY8CDUoJLRKAP9HHYD4n7qOMlH5SSwFqRe/Sa0
 vrO5M7lrOd5ca2+ZIdOGFTZCvCKaoIzrgjt5WpzZdazjO6EgIyArHX6TKg1BwIvCoNpBn
 bGL6em7vrqZccAYc8fkI/KLnEeqbuKSpCytoRHrDQ7/BjaN6N+4iV/wEE4Hyv/WYUfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800619;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=sldUvXZX8S3sLcJDVWd+JDxISELdgBEYfoYn5Qa90w8=;
 b=ND8dmkqAv0ejatPmHTo2Udz95Ft9PjUNo/VF6eMXz1bBxtljsVQFcYP1+lQGbncdFShc
 r6XIde6kX/CYUUfEXprjVsK1kqIGUyPvaGWr2zM+QQAPQ9kDxvq6aGUIBZQw/h0IIF9N1
 62kfCfAVd/FhH5QHENuIhSiziquMgGMoSRanC3AN+XvjXU3t9ABKd3szCkj/k5pyxXbeY
 Q3ky2nqgRQE2vtthLb1qD+mSiJxILbtdfbdEvtyJnZJg3G8NILVMLSQ+IiNqNqOvMN9Ts
 C308bf5oFTID/eQI8BR4YFTewRYUe4TbVQTtBf2lq6oNm0AI2EaL0RNvs18KuYltphg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VsrRUMcH; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VsrRUMcH
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7211580C8B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:18 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4877837890fso728667fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800617; x=1793405417;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sldUvXZX8S3sLcJDVWd+JDxISELdgBEYfoYn5Qa90w8=;
 b=VsrRUMcHdRMAzTSMz6MQE8yPRvD4FljoGQI8BVNEqaARo98GHvG66aYvZY5iCzX7GU
 gV/4Gg+/fQSJdP6xQHg0lfTx0frei0QHZSgc+D7x7M3F0kH4an7GW4W1+wcXHsin1+dc
 v/Or+tl8e2w4Xk6sUsx7nV8omk0gO92FEdeC4rUMBOYTWuSTW5BPzmcKtH/5jEWUNAJb
 xhwC+sjfR2+KcW+eTRoI8SY20Cxr3Lqgd9ZEg8ekjNesyoeGLKce85XO3kIxtmW/P3Oe
 mpSpJI9fO3gjuBPNvIR7uF7yE4TM9+f4vJxLa/x9OsKWeNmVKs2/KhfTb2skS1nzmsz9
 DRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800617; x=1793405417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sldUvXZX8S3sLcJDVWd+JDxISELdgBEYfoYn5Qa90w8=;
 b=pLV83ZZi/JMczLimTwuWQkg46njFiZmAqUXyffl0m0WKhG8s7MagRZh3Lrre1mH3Wf
 r6vQdzINTuJEV7B5iX8Zw4wB6Nx/TSaORnClJIHNt4P2KNiRIXKuiSBgeHgQjZ7UD7rP
 jscs2nq85hO/j8ZcMISHQXADQd+VoR5ZoeI2btp7gtEhno4FS/n0TK/0GCerhl9bjH/f
 qWSVCJ7F6YAIcfcADckz6lvJLzuZgUtyeR1EKDxuXv61NdN6ogDYpUlGuScD2+PjAFM3
 vvaoCgQCGC7wL+6RnHhLGwxAjaLYT2yd5Q/JSb19gVHWrzlxJBhwJLa61FobwE4oXPT/
 /cdA==
X-Gm-Message-State: AFq9FYIdnwICxUb2nWqsdX8SH+D2pJUxEXbF+xBL9KQOoy6sJb+MvbAo
 w6GLU+rgKTkq0r5LnJUtq2t8yiONRjD9qn7VcsWXeCwWmIduuj4l/uZaf6xxRCTiSHk=
X-Gm-Gg: AYBFou2YXx0Sa7RWnIwjqd6tKTTHLafDcH+EWsUsdBlC+MhcsyKFtobp5biuzpia1bU
 TaHbU5qF6dQcZx9hrlRvo5hWT5Z0TpYibkdg01PTk6UntmtuPH+WmY+rFF7qyI8SIQLWP+LZ44a
 AXshgkJjPTNZqKCP6B82MqTelQVV9qpABU8GhxdSpToYsqWeAL4WQA2mxDZJ3i/eb8fzCTZmjqs
 mq6uPwsREnfj5OQjVMlXAxiqP3afpGWqGzub9QYU05ijgp1zfcIHceGujHID1yvwZ1M0xT27KjD
 bDWo2F1vvvm41XXij7eS+srFk83lqnWSXTOY+E3pYFkOR2B8KNhRgZ8nRlRsCu1pEpUBL2JjYRx
 vDF4iHBYJSm6xX+jn4Y5q1ZvXw6bee7+NRzJvdpHKuKrTdLbuI9F9bkf3f76uRHkdXteLNUm2Cy
 NGXTy25UE2J49WyFeOQVXjJKWLmC3GQ7ToaM9oz6imykQX7uvJMp5J+dlIl8bJvM8FQF9EWXnpk
 bqFLhHHGyFglZlapQBkl5ZZPN3M9Y3Q8tq1BcggeKMlkm4k9wGkxsq7rypMfnKIUB3iMRjxHDGJ
 babuVg==
X-Received: by 2002:a05:6808:1645:b0:4c5:d5b0:4062 with SMTP id
 5614622812f47-55c0026d9a0mr584865b6e.21.1792800617340; 
 Fri, 23 Oct 2026 17:10:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:10 -0500
Subject: [PATCH 4/7] arm: dts: mediatek: prepare Genio 520 and 720 devices
 for SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-4-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ty2AnDsjXkr6Q8UL3yzuAy8LMHK0SkvHtp7LwmD/+P8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/dC3mfhJf+RDTQ08EVEs+cEoQJIfYxqfESdM
 GHAFa96jmmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3QhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AgNEH/R3t9BldvIG5t9zRdHLifZ/O+SKwQB0XEQE+Y30
 0LOnwnhMWT5150KV3D5GVF/rT7bYT2RBW/C3h2sVTqOKeJ/E4xLwpx8lWJq2JOF9nm8eLqT5TiW
 ZVe59Ie+zc9EE3jK1GUrzc6WNa8/MOGXnMt15xfVQEIGZiEhst+y8cus1IXFfEO84u4VsLbLaGz
 kom95vFZY6lOaP9gAkAMaa+KFXcGeMSgdh2CDkRe0DRQb+OaloMEK1QAmhsJjHLzHldu6Ft7duT
 QCIyXMie/jNAGrWWJTe4gFYljOfB7VnNBDq1U/ofndDHE2F3L/EuNPqdDr3aqCh6CuPSU1vMujF
 yPyA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Mark the debug UART, the eMMC controller and their clock and pinctrl
providers for SPL, so that SPL can load the firmware FIT after an
external DDR loader has initialized DRAM. Also mark the watchdog, which
SPL uses to reset the board.

The MT8189 peripheral gates in pericfg_ao are parented by topckgen, whose
muxes are in turn parented by apmixedsys, so all three clock controllers
are needed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
index b7a0c0a82a7..70c538a690e 100644
--- a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
@@ -26,3 +26,84 @@
 	regulator-max-microvolt = <3000000>;
 	regulator-always-on;
 };
+
+&clk26m {
+	bootph-pre-ram;
+};
+
+&gic {
+	/* Retain the eMMC interrupt parent even though SPL uses polling. */
+	bootph-pre-ram;
+};
+
+&apmixedsys_clk {
+	bootph-pre-ram;
+};
+
+&topckgen_clk {
+	bootph-pre-ram;
+};
+
+&pericfg_ao_clk {
+	bootph-pre-ram;
+};
+
+&pio {
+	bootph-pre-ram;
+};
+
+&watchdog {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+
+&mmc0_default_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_uhs_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-ds {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&uart0_pins {
+	bootph-pre-ram;
+
+	pins {
+		bootph-pre-ram;
+	};
+};

-- 
2.53.0

