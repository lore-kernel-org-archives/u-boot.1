Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C8606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QVHkxoNR;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oinABDXQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEDB281751;
	Wed, 28 Oct 2026 14:50:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0VwDyJ2mlvo; Wed, 28 Oct 2026 14:50:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7F10812C7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198908;
	b=cyTgDiy0qGmTmBmlIIk4p3qgDKibWRtDauwwU01e9ewirE711y/9yX8S+ZbqKkOaZDcZ
	 zDZ+YeJxQpSGkZmGKazJNlw06mThhQpCPBvJb8mNGaF6ZO32GSqtK8095V7ERIM93qg8C
	 H+mCWuZFTRTUtJTlUFGsmcOYSfIqjS1HydxisxQESxDJ/6ZRTN8gGsXkUgja6CPXRC2A7
	 BGq7iX2iK6adIPa4IfKWHp9RC63w5+7ry4XdKxEHrv/1l1RcLPPh0feKmgXGrF/LwmznF
	 SsdkWmeIFmpa/TttlB/7eLGY7W0ejGwocTGB8qVVSRCIAAkff7bH4X3YV7lFpdLFNXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	b=D9iNWhKANSia1OlXJtSfU4AK/HbLA7bbq41Mg0kfkgMbOLrDZz8uvnqw5I8fqcfnGaPa
	 2+OEvL6Ahb9SGcPqokulxLyJ1749wypfzc7qQX2/2HgR2unQdqmy90730zHw6YifwArYE
	 RN5jrLkVOmMZm4TtLJXURl2bnCBqfmQ8YbBF2sIqyg4DACAzGntBA2I92IiSmUTWU71qj
	 y5GP2cbVnPUw/iAG+UvOs9Ou4MIog8L0rAn+Dnt12B0iKuPTidRRE85V0RcsbpGyz1Pxt
	 df1WtiNCPmdMIZ5eWY9j32TivzaErne5zcaIO90jrTkLLdP/lnEVxnLkLGjVfNV/IkA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198908;
	bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVHkxoNRb4GpYAqb5jyvW1GwU6iyKKIdEYCXevQ08AMDUFNohdRK9wxgLBK4jGmNm
	 MwJs5Nk6mkHgcI9zN7p0qqRC9i27jWv1w2jDFX9FWG49pzeyiw7d7gWdfCyoJXf6zK
	 xz4O4+TmH0ojH/iR1ZtglY4xhBqDttnnf5rYpUYEFKnGirUveXt4RHjyTA+NDCk47H
	 XOnJgbbvXdmjgyZgDi7kROjK02JWCD1Iya8grRZ1W+3yFPBF2LL9weuRYGYcrOyMgS
	 kjsmHQCUjqHJQD7KH7zmEl9H8jAIIi459DhqN3pdYCy05Vs2TUmiry0f2w4SPYurwU
	 nDvMpGkr6483Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7F10812C7;
	Wed, 28 Oct 2026 14:48:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03484235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD30F400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uv23PPriiXl3 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C02A74008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197024;
 b=HqzJ/Kpq1NtuSW2uI2VZrfxINQ56tZOQA1HZv2MkzPI1wKMIh99k8n7g9dX7eTZr3OSz
 qZA19aIpQ9SD1spObKPhiasRn3MYktEWhgGrugOJNuIxlNXYv5682Gf8Tp40ltg5Swlly
 0wVu/pW0y0pVW/UPin2CmoycN4JTB0EmTQuI0SMucwCQS6DkEva59k+u363M1fyPfKq8L
 h+su+JCq4uWVCGT17jToRDYBrSqXitxfQNnSx+W0xyV6R4qOhAOwEM/eHxMmAfNOm26kv
 b5JNjee6JdIVcMna6CDzWXmhC/BDVjJ1oAwWORcWSub1UeTCqO5V3rd37zOJlXPIHdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=lq2qD67gdLruhRDfsLhxUIwoztwiNW1iUX54b8O7iOckc8PA4wFXFVieGxoXILkKXd5M
 oquCzzr14xd96wj6LLxTt4nrvkRKb3I283hycVxn6d6oY68Rw7IVcWt/9dyazcpuJZ1qa
 CC5L1nOSb6OzGnBcZJLT479lLEM/8tOswt9g7s9pn6dYKSFuDGoPfNIlJSL+H+Kn+aZYq
 R8Mra4Z32pf8Z0wD0YFjwH4hWGEMvfrDSGS1koNgdaHopPWVqUBVz3K/ft9tFDj4wFzFC
 95H3BuD4cw11thAze0/ODua9v3/2QPv/BTUWhKhqcjd98iH/cO7VSn1majH4+yH6XVA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oinABDXQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oinABDXQ
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C02A74008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:03 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4015fb0b42so10502266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197022; x=1793801822;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=oinABDXQHwiv7jeIexVKzCP1ZH5WvbHt/N+zEq59PSU/BM5QfxbASZR8BxCzFqtjvP
 pbuYfpiMKabX4wKumJl8WSzIDHIig2ZVqwJUEH/JGdIXUMvad0Y5B2kLJHt4AqXEhVJR
 j72GDZ3u+y0oLaqB9Ns3fD9KlcVydKF75A/K0Fl1dnvpK0D5kwMabLkrI1/1ZEL04K4c
 zpbo2ujay52OH4hTdWeEAHDzpYQw12uCFK9uLgJ12DjFfjy/9aprHC+BCAgM7tIp5Hpt
 14VjD3suHPMZ7PoUGpVgKTZ5DtkQq0HTuhRer75wFyT9TGnbdOaRg447hn4CRjTwe3tG
 nUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197022; x=1793801822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAeKLD8sNhHTzsUYiJvvRgAlmPyKWA9ryK+a4/2y+SU=;
 b=sfRl8F9hmUpLrP3udk4noXKzEIhvOj3288OFRBS86kGb4+AeqdE1rlDw4ht96YdC6G
 cTTr85oQ+2XhXCcuqtBx3CnOVCwQyFXRELXGrTQwgQqB6ycH5LVefZ2JMyq5s+KVv+sA
 smzh7gvtbefT913XiRuglYjTolVjTFThu5DtNeu9aNSkYRwUsCPS3NVX0dcY2R8DV8o7
 QldiuAJIyouQ/ktmx4eKgnFxu9nddDOwHeI55vJ+jJPlnYtpyCOkVZ3GOA2R++tyuwVm
 jM7JrWzYuS4ufB5Ekj4iTmy6QmkZst9fY3ljDLv2a08eK2mhWJvy+CUkuLd59g2MELcg
 xzyw==
X-Gm-Message-State: AFq9FYKp1Gw2MloCU0tLLjlwsOD0A0X2n0qI6FlUHDkvpVBjPvSQvkMf
 pcS+EkG7+O+dMX8dwkEgwwGVc5gisjHXFM0hSfeUZp0K38V/qBMQStl3lfaKsZMDKL3sEAAGqUQ
 qrI1G
X-Gm-Gg: AYBFou2XV5hYMWe8d4MmvT//TwuAUYSQwsWsLkli+NRdrRGZgW5Gtdx7eKwa2IHV9YS
 8mdVTuxmb9ijcex/rrLcBGX5bO4XxB8PV4pGAMkkl8mA0Z85UmtDjNL/HwcVsAP58M+NSt5woUc
 w58iqTS+jDefLnyaLIjSTbSVxY8JLZ+Ue7bPl7GRz9JdFmWd/OLiEJFNVHP6ukj8yBqyexLp0EF
 me5U4gBNux+L/EOUb3I1Ot7YX3Rev013QovpXUXzCht63BnG8tMViRisbZBKD+yRcdUJWQP4LjH
 8RC877PGq9e1N9K19/kYHw8Lf8xDSk73630F0f7WBXtlZydKHnM/d9knF0oqhmDHmU5hvJJ5xRF
 fTkEEcY9xkppt8p1tNJ+FcdEmrN51hKHySpOm1xlppr0KuIq66xc9RRJJbTuBnvZIjHxT/7b9HK
 j46JA2D5dtDpVhtgh4FRcSFTBKyMNV2ULuGPkE4e+p3PhehN3YrNv2r9q6SPm/KFSv4ZpT1+I3+
 rhaqjSHzothFFHs79OxDjnIOTUvqfC6kacYCTXebn6xJhzAhrYtlsz/6I38mKCS/uZ3l5qCxtzW
 I20bg4zgf8qAtEIecpozLYKWdQk5Qe/bJKwzigDomQPdjZV7SEy7C0RyQe1HC2T7JdASFS6KnRU
 QgK8mLXPueQ==
X-Received: by 2002:a17:906:5a73:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c49bda28beemr270853466b.0.1793197021550; 
 Wed, 28 Oct 2026 07:17:01 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:00 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 17/30] usb: gadget: ci_udc: set endpoint capabilities
Date: Wed, 28 Oct 2026 15:15:41 +0100
Message-ID: <20261028141554.3073545-18-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. ci_udc never fills caps in, so usb_ep_autoconfig() finds no endpoint
after the resync.

ci_udc keeps its endpoints in a static table, so set caps and
maxpacket_limit there instead of calling usb_ep_set_maxpacket_limit().

The names say what each endpoint is: ep1in-bulk, ep2out-bulk and
ep3in-int are fixed type and direction. Entry 4 is the template for
ep4 and up, those are free, so let them take any type and direction.

Tested on an i.MX93 board with ums.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 87194601f67a..69616b16b052 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -121,28 +121,57 @@ __weak void ci_init_after_reset(struct ehci_ctrl *ctrl)
 static const struct usb_ep ci_ep_init[5] = {
 	[0] = {	/* EP 0 */
 		.maxpacket	= 64,
+		.maxpacket_limit = 64,
 		.name		= "ep0",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_control	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 	[1] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep1in-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[2] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep2out-bulk",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_bulk	= 1,
+			.dir_out	= 1,
+		},
 	},
 	[3] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep3in-int",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_int	= 1,
+			.dir_in		= 1,
+		},
 	},
 	[4] = {
 		.maxpacket	= 512,
+		.maxpacket_limit = 512,
 		.name		= "ep-",
 		.ops		= &ci_ep_ops,
+		.caps		= {
+			.type_iso	= 1,
+			.type_bulk	= 1,
+			.type_int	= 1,
+			.dir_in		= 1,
+			.dir_out	= 1,
+		},
 	},
 };
 
-- 
2.53.0

