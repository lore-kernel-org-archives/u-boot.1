Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C71AC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 11:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A2C82C4C;
	Tue, 24 Jun 2025 13:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750763095;
	bh=Qi7QmJxkb7chM+fNZbfdBuvVIzG6kAjn7NVV6yirvfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=n8CVR69M2AhnhRau9Cf0/RItcJ6KkLaqBb2yoN0KDoiHS7O9zFAyCdFAIM0JS/W0j
	 2BT6JW2cRR8zdVvsdgyW8DZ1cAU17GCNsJgX3ydH0Q+u5THCD3Mx3x/14m6yWOybfR
	 m6UGH1HDZYDgbvsaBB7MPGGCLHbPVI4eHJyQcY7gxJJayI2qsoSR3NV0ETjJ0HiFbP
	 mvJ4zSo+x8e9zNMn1WUnPzyxmv7SpfQqBupJ8flKtrrAv2nwjuHy4IdarGbGHcdiz3
	 9l00qR2KsHNITifho/vXz/FAmOy1VcXkdRpu+l9TSAaTRAhj7R5aq0T63wFHXvhlRm
	 Vz4i4WAD7rNQQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5719182C84; Tue, 24 Jun 2025 13:04:55 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7D282C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 13:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gUPv4PFs"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D358101E9287; 
 Tue, 24 Jun 2025 13:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750763092;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Qi7QmJxkb7chM+fNZbfdBuvVIzG6kAjn7NVV6yirvfA=;
 b=gUPv4PFsCyHQIt7ocJkipHkb4NzaN4idNyBxLh9XBExSTxjueQZPbFZGfqyMYTlYmyLn3F
 lrOPWEQd5fDFZjOJiICKQQg7IocidFCN1UrSBZId/QrjwCSXhmw01y8QoS24kuootbCKSj
 jTdMg6BQmH/A8OzxumRZoz4JThPS5c/k8IQbe/hbfXEmwDbRFC4EGw4tZl3Vis94SrHjJA
 QfPySZR8SoxuUmak/OPtXeL/9nGgbH3DoXOj+HminebxyLlkm0kz3uiEvUj2sTvaIpCM+/
 iOrRpk+b68Bvh7Sme6o88cgA+9p0pG5c4oKru/zRT8QJUMryR5U1W4DNwg/35g==
Message-ID: <12ad2c11-1eab-8142-c740-21f3a6af60aa@denx.de>
Date: Tue, 24 Jun 2025 13:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] tools: imx8image: Fix the value passed to dcd_skip of
 build_container()
Content-Language: en-US
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, trini@konsulko.com,
 festevam@denx.de, peng.fan@nxp.com, alice.guo@nxp.com, sbabic@nabladev.com,
 uboot-imx@nxp.com, eballetb@redhat.com
Cc: u-boot@lists.denx.de
References: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250624100922.1702045-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alice,

On 24.06.25 12:09, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> The value passed to dcd_skip of build_container() should be obtained by
> parsing .cfg file, and should not be fixed to false. For i.MX8QXP, dcd
> data needs to be skipped, in which case dcd_skip should be true.
> 
> Fixes: 5f28a6599f01("tools: imx8image: add i.MX95 support")
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> Changes for v2:
>   - send this patch separately
> 
>   tools/imx8image.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
