Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F16CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 967FF405E2;
	Mon, 12 Oct 2026 14:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVd3l62RwUNO; Mon, 12 Oct 2026 14:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E35644063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813702;
	b=M7/4V3o1B6rcptEP9/oyO250zB8j7jMnHi9CdQ+9/vXeOkY6vjI/dnUipgy066S0tfPg
	 npZp14t3jQhwcNMUN5YgUgNy+7L1tVtoiIv5gxCttuz24Qet53QMfLMbKuogmq+QRFWhx
	 t5u5Un15BXD9VhCzOHsY8a9JayE+mYtdsSy3RpX/IMdNNHMesTiXMQbnrlwzntL/cEN11
	 YKgR9Tdldm6ml5HkaSEhoZgaxwX20DrRZJWuyCgTzFWYrKz8HQ3QSmEpHCrGmbtwdYWA6
	 huTt3XGBAu/HNC5HBeOAYm7gZMZAu7FCAUUJe5KM2OhB3vNWum0tsgcy/3EjViUQPqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zpElUv7lb0HdX6PWGga/yrr4iXUea7cVqTJVsOTqDFo=;
	b=esO7iBF/B+qFvDJkAheZatRT2oE/tmvbgEtfbkxvqN3Yvsd6beyGpUIvwvflnhwmc1fr
	 s0ZnBmUyRdX2/f1lE9M5Clx07HJMmujONzXSPXZz2NO8rrYpSQUMB1gHIytwL2wu8jBLu
	 H7GVsSxbHGU3cRd/OP2PviEjwdQS5BOUT0vb/1CI6JBTqRK7iFwTaWyMWtz2QRba25002
	 UA6enMfRh9KcHeNWcUUQcv+n1IJCaFrp+nvfkPkmlVIu1Ny4NA3BCbMRjbmwrRD6C25A7
	 0mQ5UuNYw/ZH9ZrHLAr+jl9LKKtSb0mihulMa+gaYBSLPqjgUbprSNSlZ1jV25CJZ3w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813702;
	bh=zpElUv7lb0HdX6PWGga/yrr4iXUea7cVqTJVsOTqDFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gBw+cbcevCP15/cYnQAcihiEXO4xxDYp1DKV9UCOKjqsVlCAFuhSMRyYQyiprahif
	 jEsn475pwzYsry4rx63EodBeti5bIDN8DvuOHk9jxK49zn/W8wcVzB4sxC/g1elXgc
	 Z7KKQZ5Hh/vB40Le4bb7QuiJIyOXxOg1Uj/U1CiMUJ/btmEYtxo8w+D4Vg0SAh85Ek
	 OJ94JfeWty5llK9PmPEqZGLdm0E0PmVbduoSVK/gCidVoT3sF8sRYs1fR1V+YGm/Va
	 Hp+cr+FABlw8hNX13kHlGUpNAhI0pxVEyiSwC/b81e83Zgm21H82xg3LZR04tBpwGi
	 g6o898vajrzvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E35644063A;
	Mon, 12 Oct 2026 14:01:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1FBA179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D87F0606D5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmuCmgiUAehv for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1DF85606CE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813699;
 b=kTummWjHau1IZHHvdree5SzSJAz/XFhlSyQxlNCxpGWnMSDOE6G6JQ+NwCo+uNt63JTL
 YQYzuuy3HtaKUETyvjS/VKEPG95oPd8HPKCodx/HhiYJDLdKNUTZfASSAGYg72bzx0tqT
 N0fnfl9bgRxMXWBlZ1dZ0WHAq4mOFJ6EnktILPdS0EJOEtcuZ1PjCEmkr0l5k4ILgpMiS
 IRyh9U7oyz2gZ7uO233m68OlPbNEY/mTCGXNWVBpEpc/RYfPH+LBMh91v1pMMDghwtbde
 Zuudv27osBcmmUC9gcaEQFKw3TMQkl7RJFTIC+apliC7084XChnl02b59WmIVZMKKaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813699;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=zpElUv7lb0HdX6PWGga/yrr4iXUea7cVqTJVsOTqDFo=;
 b=BnLLDGbIcKuCP5bcy2fZF3GPw7UQYvXU1xjIRi3qIbZUTd0X8jSpCwVMSeSy7g895v5G
 wbQRQqNNtcN1cqv/ckyiemHix4k49SP+qpdKv6/0znyIMoYvKsbsqqlhW8pm9VWsUlnHA
 7f9NGja+LvBssOFCMgTPr8UOVEjbASAqo1ndCLlViUep+bmGcilnzTgjEGjgr6QpeVyf+
 gzc56rT0+DGkZuRIrv1ZY9TpnRK/v1utu8k058h6l9yboRUSyZVkCeC3aKPsU6kjhOvrR
 PwFCZZqNJqhFQZDhTs9RrEeI+aZUd23gebmtwhneXh+iRGFwQqU6sDAubkOD4OzHm9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=GD1+oTrc; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=GD1+oTrc
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DF85606CE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:38 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8DEA43F285
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813696;
 bh=zpElUv7lb0HdX6PWGga/yrr4iXUea7cVqTJVsOTqDFo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=GD1+oTrczn26nkjGIZ/pBTAW+zJNbMpmxQCLP7sbwzlj8NArTobgJ1KbJ4LQ9ZDEO
 TYfU227q2ddcV6aagTnqwekaHqzXWmFX+iTYYuBsS4ne4PftTLebszZQvgDiZVFaxq
 QUFoOHrOm1W3hAOz1HTVxUwCybfLzPXx5hnwvOjYYSBeVwT6VvTdfgRsAgMqyoh+QZ
 gwDFHXtPfrjcVFDUXbJ8UtmIzbNdDkGMw2j9oa2A4kB2O0jquN6pOKtzh3uozVeJdd
 GldKRbG+SG5iheYOQJANaiY8Moak41jHAYNserFqpFnH4g8Q3k7J7JlLQnodC4ghwD
 rtJsvu2Ew0AjVY+0Msa6U0tCGgtvpjb4CKtHxfMnPxIfYitoWJP4HqPe7nIi7SZqTv
 4STFVQO8bzmmPkainX8chw+k9VIfsHO2TbjPOFE8D5G8jMqCs8WR1XpVAiXXrmEzCo
 WnAMEpB8H0kJlZDa9mISavV/yzXxWym+golcTaBMpb3a24seDeVQ+XhxibxmCtvkx0
 +Bq0pFv5tfVFJMCsSAUK8rprGBevZVcVApwpaLH74obHvJ1J0vpnJtkXL3Nta4uWZ9
 204RYq16gJQjjB4DqEu57bBsZv25dzkCYV87IOnzX+ROjmutNK1kjLydU44wit8IuF
 krbSHwlQJAgd0kMzlzLOjoKs=
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c2e5d6c4e8fso167610866b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813696; x=1792418496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zpElUv7lb0HdX6PWGga/yrr4iXUea7cVqTJVsOTqDFo=;
 b=fKcaXdhqmhg7BGpP/NRY2AJ0euCuoP0aqEaDTU0oLi7aXrtwLTiUZZdB/opw+OI0FE
 Gw/AAScp2o53p3SKTuoOD3ddavABmE1YB8vrinBJj/TD4a5Y+mRbYUKGp+B6zYUb0QT9
 7yeJHCpmWxB8rRjK7TI7X+H2OIFi7JVPbmyzgrtavOXtoHuS9u/5ZJzWYU52tPpI4zeN
 H+ugs76axCImx7oxzeMp6iBth20khSZaOESPOkAlufXDjwEtTVzYUWMiogHt++50bBzI
 Cepu8xcrzkrzLDhVLiaZKwnKiN/E7dN4TrUuSWE2O4wcXAi/gHaKY9hxqkutjDgTko3d
 1G0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUuxyO6l5AuPoAEg3FncZphEdVZ/bYhyOXcK+4OmDysHZxamlppfMCkEM4+7NydS2p2OnGBdA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKYXow52IqL3hjY19pVsq8W8O1T7RyJKkIFbrWbIpQCY0QYGxM
 LFSdIGsmGb8BHAP5je2qUtCM55RVUfnzEvncDDF2WUoCzGnGbXNJX0bQ7DcjJDwK2G+WaF6DG82
 TKCUao1C3sylzrDaRA9rA/WHv09IrlvK997zTxLG71tl1W7oJR3jFrnXeUajNCtneyELn4scQx1
 er3Tt9yiebBFUNpRtnwQ==
X-Gm-Gg: AYBFou3DHfFLdY/7S9HFFy7n5CmdCPnzAJTsPubG+7QgFAKkQHzMkzUWe4dUjDqnmDZ
 NrJZ1lZBgkLT5IdESyn5P2S1+1dtNDpVt+rBH/UQxLdTXl+VentyQlgOWw7XPF1UhUzWt/2ISYc
 K9X3UPVh1J72dCLBCnyCOKSKIxS1L7zbKVnBVsgln7z9OH2fnk8AQu4Z5oXEKKIMi5BzIG0GEfR
 /l0+Lsr4bVRGpVapimLNvy/eZvd20PY5hxgGNiTGKGOOAf7EbIvZjo1Clg+wXFn1b/epAd2JgeX
 1OsvU5ZuQNPX/KkP7xqXZCtON51VcF+bMsrfw7GzyKO0Z7dfr68mXd+scn3m57HFCGFmbioc0bb
 CeMo3sVIQ+A6W6II7WQHLHRGiyEXlUZ4514/aomqWiG1Zi+zNNz+3xSI=
X-Received: by 2002:a17:906:c106:b0:c24:6f60:3f7e with SMTP id
 a640c23a62f3a-c31a9a28f90mr937168666b.2.1791813695742; 
 Mon, 12 Oct 2026 07:01:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8208:b0:4a0:1b14:d00c with SMTP id
 5b1f17b1804b1-4a18e446f55mr176937245e9.3.1791813683844; 
 Mon, 12 Oct 2026 07:01:23 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 8/9] test: env: allow optional date field in ls output
 assertion
Date: Mon, 12 Oct 2026 16:00:47 +0200
Message-ID: <20261012140048.214059-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

fs_ls_generic() now prints a date between the file size and filename
when the filesystem sets FS_CAP_DATE (currently FAT and ext4).

Adjust the assert in test_env.py().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_env.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index f8713a59ba9..e9d502148bc 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -523,7 +523,7 @@ def test_env_ext4(state_test_env):
         assert 'Loading Environment from EXT4... OK' in response
 
         response = c.run_command('ext4ls host 0:0')
-        assert '8192   uboot.env' in response
+        assert(re.search('8192 .*uboot.env', ''.join(response)))
 
         response = c.run_command('env info')
         assert 'env_valid = valid' in response
-- 
2.55.0

