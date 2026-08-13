Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3566CC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E774960B3F;
	Thu, 13 Aug 2026 15:57:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47qb43b1_pAF; Thu, 13 Aug 2026 15:57:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4937460B2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636637;
	bh=xrkB19Bslz9uENFy+iC68xbw0hBXIGafHjCsZBumuDU=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=t9QQaEO12VsMYxC+XRmYQeuMHCBDgWDa4ZI+DNm9f4eJW5py75yIcDygqSj8VDUXR
	 T3DmIqGjkDLu4TtvG6qCoMc43zN1i33J6WszdE4x/Fy77QJH5fK+75rtZeBDr7BDcS
	 rAAJMD89zqRTphUvk/eDE3+cRdELSOLTSOAYAqSJtCa4NYZkNDPerlYAqMKXSup89t
	 cDhcCMWpd8F8DQ8hiOH/oBSLq0s9qS1G9NQETymoibtNGKPpy0yZOEXjyOFTZhbrKw
	 4hYveuMTv4ivjxjJokndJQErIa4Nb6+JkbEZ4BU+MRkRuMLh3BogiCfq2QjaDBXP93
	 mRMvy0wF8LnoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4937460B2E;
	Thu, 13 Aug 2026 15:57:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F358F259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9925407AF
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8p90174I_E4P for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:56:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 936224078E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 936224078E
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 936224078E
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:51 +0000 (UTC)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D0EE03FBF3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:56:48 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so867579a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636607; x=1787241407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xrkB19Bslz9uENFy+iC68xbw0hBXIGafHjCsZBumuDU=;
 b=LyL07cypZ6JD1rgHD209aDRF+iN7Zjx1f4qoBlwjblrIXSIirJu0PqivCBpR0ZaCSQ
 i68Qn8sBBF/uK1jiuEHlKwZ8np4SWCrja98Yr/clzvvlUhBTpBPl9UsawhV3T1BCD0Cb
 iQ50UP4JIUlpufJSIHh0LJ2jC6raWKZW53F3EV+8nSXPaupmWYVmj/5JveeiMsi0hC/L
 BH+L1mLPbXrRE5OMyPBHuaQFGvqPyrc2KVb3iv1JmBEM1p4Df7i8Thirlmcqh0162y3L
 FbKWseSvDv9PaeZDcIiujl0UtdaoZfpRVIx9DbrbCXqXK6ZjbBR4xXXhL3/+BqXgOtIu
 lE8A==
X-Gm-Message-State: AOJu0YwQgccpqNZHyLvNerfBRZ4Djf8PngUu1D2+Uxyl8QFIS8f0QCUc
 MDrYXpgYR7bpHB20QqwwA7Q6lopARm7XviVYGX8JaFAcvvnwt34XzVxZBzVvF52tI6P7/DTc6Op
 KSO1pLYaBEvJLm9wdBQNrBu5Kqmh10V9HXOtJ+GqosH9/SCUl52MYCdw+Br7BrZPh9WjpknTls0
 fqXGm9ep2CeoPk59np8Q==
X-Gm-Gg: AR+sD133BqYELvlgx1qe/W9KcOzPFK/wlVPF0qHCcMgTnAWgZCyhWFBzj1OpiKjp1Ke
 Fl12UH+Y06YF8BQ3XhN7JsQWCvzutxue/uqQ+qelXyjBDR+rbbQjpFcmwfPxwsWoDWU4Zm+KdKk
 deECFW9nSMRvF/Pv2gGfhJhl4q1uHIANOS5bKogGlbXVop6j5LbPLuNHyMElvs8k8BbkZ5CaxfO
 52TCi51l3tmkCPss86odtm+WMGr/f2trKnsHsEDMccjqiOeM2OJq/GSN2/mXPKuIcqnuE6jgpuX
 lIO52MS70cuErsj6i4lCgqnungyHfHnxIpbAgFofUHrH5OjITdISwky2HQfnQ5FDlISW0Ujyr50
 Fg305UkeF2xEXr8nO293A4wBa/6gGxz+FugP6eO33QeCqv+cFRXQ=
X-Received: by 2002:a17:90b:4d90:b0:38e:c1ba:4f94 with SMTP id
 98e67ed59e1d1-3931f44ddfemr4153027a91.2.1786636607161; 
 Thu, 13 Aug 2026 08:56:47 -0700 (PDT)
X-Received: by 2002:a17:90b:4d90:b0:38e:c1ba:4f94 with SMTP id
 98e67ed59e1d1-3931f44ddfemr4152984a91.2.1786636606663; 
 Thu, 13 Aug 2026 08:56:46 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:46 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/7] bootstd: cros: Clear bootmeth_priv after freeing it on
 error
Date: Thu, 13 Aug 2026 15:56:14 +0000
Message-ID: <20260813155617.184928-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786636608;
 bh=xrkB19Bslz9uENFy+iC68xbw0hBXIGafHjCsZBumuDU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DO0WRMEHXv5nRzUnk/he9WPkxjOilttAeu/bFNDmWeIVgrDs7V5mYRuYIug4InVzi
 UuGXeKgOoCFJw/MRGtsc8urDnKtJF1Blu3qhl/7pSInhaxNxuPv4Doa8QX4CWKvksQ
 WL6kvd1+gOOL2j5CTQCR7P3WYlGZXYyUMwWNxVDzY/N1lw6zaDPl2rP9gbXz6NNU6A
 81kX38Io+fNvHO1ZQeWjHeIShsdbUm3c1WGHFaT02v8A5vNbylpJ71rS/IHS+cOqtF
 Gues/uGqkE4zD3UoJhRTbZzp4/Y8NXnRNeb8eLIXBmm32POD2czevJ4hG1zM6Jst1d
 aGIDKcgMILfkancCyKogN8vQVuatJ7bJ4ka8YfplXS45Be8eMwd1JNFdhhdQUJSe9P
 +P8Ua4POUeUg7MIDwMXW7U9ysa1708Q0LHy5CmlYqhC+PCJMxP8eTNfXKvqfMS8Zmy
 U6JNEUUeszszO9YTRC8Cg4KqIrN4RsqwKnZHOLlcSaQKDOJaV5YGgpGr+vCxU/wcLv
 +oOFqyo+CdlACJF4yYRqury854bDRHl8ehh/9JZjLUPrxXBRCy7/s6UFIObVRRhoSM
 zGqeN3lyxLgKhs5/1VXgNNMQmhF9Tbau2hp9ZwUa1SGYdh/6xI+KYOIvbULU3/ke4M
 TayYOT2YBhUdjVmD5UV+pMUU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=DO0WRMEH
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

cros_read_bootflow() stores priv in bflow->bootmeth_priv and then
calls cros_read_info(). If that fails, priv is freed but
bflow->bootmeth_priv keeps pointing at the freed memory.

With 'bootflow scan -a', failed bootflows are stored in the bootstd
list, so the stale pointer is kept and bootflow_free() later frees it
a second time, corrupting the heap. This is the same problem recently
fixed in the RAUC bootmeth.

Clear bflow->bootmeth_priv after freeing, as bootmeth_android already
does.

Fixes: 71f634b822ae ("bootstd: cros: Allow detection of any kernel partition")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_cros.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a..f894ed78e3a 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -405,6 +405,7 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	if (ret) {
 		free(priv->info_buf);
 		free(priv);
+		bflow->bootmeth_priv = NULL;
 		return log_msg_ret("inf", ret);
 	}
 	bflow->size = priv->body_size;
-- 
2.43.0

