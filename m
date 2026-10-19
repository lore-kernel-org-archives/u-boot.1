Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16A3CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8317F406AC;
	Mon, 19 Oct 2026 11:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3u_Wn3_ho_c; Mon, 19 Oct 2026 11:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D950F406C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411120;
	b=EdVewMpS5T7Jq8VX0r0v28olws9kgUSwjITPSSg93I48Fbp7AjBxgM5nesn+f3UP2APN
	 kJVSod93wDzV6kdcEJ90mVlc68zZo3qMXxJQIEkRkiCca3PmOCQiNeFvGL6Y5vRu2Jlew
	 h719x6rEHaawNe+PRtunnhssDHijctdL+RJ7+SLY/KSuaGFxzPoIVio8ni0sadNfc/WuN
	 GjLMXZuE0cz81HGoqjX3F7xGD8rgaXifKrsK05WfNvaCXo9wIUnut0w1oEwq27qzoY5rE
	 LvsksLmBf2Cr5r3iXZUJCAPK2FxT41om4oHQR7PTH5nh+zCqT+r6lHWz6W7vVzqFuJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OGwEBPFWAeWGfTVMjYg6wHHvpuw76OL+en0yzTLlT18=;
	b=kl2qVCkzeldZZYKMqeIm0vKb9FQwVJGVPW/X5LglkPJkZ0YgQPWpNugciw30Ydg1Je7W
	 qMO/pQ2tmIpwOKwihDPxXEuS69owtRlbtQgliB9kq0t8f/HN8nZZAu7DqJ+HBYHLc64g1
	 aq37o8VALWpSTyEQ/pDQUcNiJ8lPXB4vJlVqp48jrSaLWomrooNJk4qZ5EmYQXiVn1Qaj
	 kbC2fbB+kvG3/Dm3zDXBeiO7UoMqHExzAaTR+2rXxG/FcydBO7Yn1UGX79MMckAPNcr9Z
	 edxrs/zNuBy7/lqC49Z8qNW6i4M9nIs81qS2rs9jCO/+5MTKcrlywifkicyvXmvhVsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411120;
	bh=OGwEBPFWAeWGfTVMjYg6wHHvpuw76OL+en0yzTLlT18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUBeBRNSq4wPkK2ahJYOvu/F2RT1Ly1dv8AjulQ9JW1UPK03KjJkszQTJwocF0RIp
	 ruWCVrrDHF80Fw5qXgHVHMGs7rBOtB/vx4AQEQ/cO6ZfGsUPaH1pPPkbr4LZq848hF
	 CWYsrn1mwLIXlW3Ril28g6ryEgeFXkjI4fUte7UMmXVwJlzsv0HnTcbGYGGgUf89Ks
	 rqURy8u03oUk4S577bfDyeEK361CzzwAAe3L0zBpZv1vKUGoRi7g5C+SrxrlScQVTk
	 8Z6+uyJPnJH07lgOctVRJ8eLoZfIiiT6zS17upDR+K7jT9ZwTpqIJPxma6vNv9M8ep
	 L8olsKs+5BQ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D950F406C0;
	Mon, 19 Oct 2026 11:58:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65D971E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57C9A400B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdGc7pL5bco3 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B2CC140079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411117;
 b=M6YdfFXdTBxb0dQSKeYTkOjSkWGhYsDl5XiVtOigdFtZ824e+0oXE4Ooy/G5H9DpBaru
 cLCLYMpdnpbrD713l5r+zW1tTc6N6axCbDGGtVqs87DdTIzu2dD+KRzcrB0roObo1NVM5
 g9mCLCobQno4oaeJoQuL4OqMGg7bbKukNvUzIJap6wnvpqNF7KTHGfd4xhJgVCUXl+MHf
 EHGjvz1MwhJyq9xyt65eD/eO5IcGdeUTAPkZZXULwOy4GH/e4TwvtCm76o+fxSrPB3zfc
 lziICvGeNKwUjHvPSgxsyoDUwNuixeJNY8BoszampFWEykWypVv8qc/1oS0H+QV6PgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411117;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=OGwEBPFWAeWGfTVMjYg6wHHvpuw76OL+en0yzTLlT18=;
 b=CUjTgN2DearyN36p4zZ7b3yRQcaGOz0SgbHeuELp3n1waxxIZZn4iMToBUoFWqUiVE3b
 OGyN2B2LQAedrXtshSkH9/FCMFI7VG87VqLuUFoNOl3HIcCZfgI3ES1bQCvUuaz9dmcx9
 cPIbWrV7MzWE5dFdm4yoq4osUW+ZN88ndXfdA/YrpWpUPaVz/U43pxOzXSK88ihCt9ofx
 Fx1Tgv3NGLOmBJBL4FX8kAvHtQLajl8NmxVxm5l0j/izLe9WbI6tkXfclN86esRkCH66r
 ziVwRgILWexqXKRxSKJA+Qzfcoe0Q6m0RUsR1FzfjE5f9UUjk/DuozxkX3Olq9E02jg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ojWwsQEq; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ojWwsQEq
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2CC140079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:58:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DABF405F6;
 Mon, 19 Oct 2026 11:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D24E1F000C4;
 Mon, 19 Oct 2026 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792411116;
 bh=OGwEBPFWAeWGfTVMjYg6wHHvpuw76OL+en0yzTLlT18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ojWwsQEqy8nOhxZ020H1DvB9QsK3olT42By70AkeA5O7fYNZ1zlTnj3cMjTv4ydJ0
 TOx45QQnecCpCUdXzvNBkMhaM9Wc69hyWzzVU7Buu/l1iiMGom/kgXiczsMStlYwGC
 ShSnn7mjqkaga9J7iCcXB/r/matf5XIQJlSoChtvHULmGYyct03QGjblAlm5RiVtsu
 OA7s6T7SQEj6iwi6SFGQgsLuDs3xnN1eF+PPGu4kcGMO7Ll4Vf7LsZmtBZdEhODnaB
 W0iWeJsAMUQELKg2jYgKmb9z0thkSa51L8YqWZF6qXqsZ5Qr7hMC0VP2XmlGeaiNeH
 cioCE8QlLco2A==
Date: Mon, 19 Oct 2026 17:28:29 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 5/7] arm64: dts: monaco-evk: Add reboot-mode support
 via PON/SDAM
Message-ID: <atYF5T2LiJBOU3rT@sumit-xelite>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
 <20260812-b4-monaco-v2-5-865d288c0be6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260812-b4-monaco-v2-5-865d288c0be6@oss.qualcomm.com>
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

On Wed, 12 Aug 2026 at 06:42:03 +0530, Balaji Selvanathan wrote:
>monaco-pmics.dtsi has no PON/SDAM reboot-reason storage, so
>U-Boot can't read the reboot-reason to tell if it should stop in
>fastboot instead of booting the kernel.
>
>Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>---
> arch/arm/dts/monaco-evk-u-boot.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)

Avoid adding DTS changes for targets that aren't yet accepted upstream.
Try to keep patch-sets independent such that they are easier to land.

-Sumit

>
>diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
>new file mode 100644
>index 00000000000..5520d111864
>--- /dev/null
>+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
>@@ -0,0 +1,36 @@
>+// SPDX-License-Identifier: BSD-3-Clause
>+/*
>+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>+ */
>+
>+/ {
>+	reboot-mode {
>+		compatible = "nvmem-reboot-mode";
>+		nvmem-cells = <&reboot_reason>;
>+		nvmem-cell-names = "reboot-mode";
>+
>+		mode-bootloader = <0x02>;
>+		mode-recovery   = <0x01>;
>+	};
>+};
>+
>+&pmm8620au_0 {
>+	pmm8620au_0_pon: pon@1200 {
>+		compatible = "qcom,pmk8350-pon";
>+		reg = <0x1200>, <0x800>;
>+		reg-names = "hlos", "pbs";
>+	};
>+
>+	pmm8620au_0_sdam_0: nvram@7100 {
>+		compatible = "qcom,spmi-sdam";
>+		reg = <0x7100>;
>+		#address-cells = <1>;
>+		#size-cells = <1>;
>+		ranges = <0x0 0x7100 0x100>;
>+
>+		reboot_reason: reboot-reason@48 {
>+			reg = <0x48 0x1>;
>+			bits = <1 7>;
>+		};
>+	};
>+};
>
>-- 
>2.34.1
>
