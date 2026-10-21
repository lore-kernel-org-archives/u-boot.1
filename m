Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68389606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G2Olcf+Y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qeJfAbcW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4188C61777;
	Wed, 21 Oct 2026 18:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XONGe2a7imrY; Wed, 21 Oct 2026 18:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F8CE6F4BC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792608115;
	b=Un6SmLIRSKzwL8TE72dvFWRBDTXld/TD4AzTcu2EP4UBwZe2fCro9eTg5f10Zv3jgyvo
	 s+x0iRpDFU8tLBdaVf1lhOuH2/kmI5uUIe8sdbzGlU6b6bSwyXktcEeYb7mVFaLAVlKFX
	 edk2OQhMaTWNO4DdpWw2bXWeNCKP/81hSNYv56CXcB0pHcGXDRfDg2BkWcaiOr7bgVGCb
	 bPHToqvWqergLmBkxUOflsDXFG/+X434OAYQfqkw9GMJMeVI7uDk0XpJzN62mSJNV49yb
	 uGYAJScsW+ACjFs/NSpYKVHw+uuFDIbZ/NBQ4CS3k8RQ0K1eLMe1rPiS69GnlSXa6/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792608115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xHUq2GfEpOC5uRnZyO0OtJsMt6fLHGftPlB/0ud7UAw=;
	b=eNjAtvPBFhLFCGvQoRuqILcx4jAN0C3LaL4Lluc/7EMGnu6dTsfw8pbRZvybfC7uDoFT
	 CT/TcLNDvyBtHK5nbj4RHv8II8lzoCSzd6QZr4OXG2tj+c92Kk4YZvDyMMkKo06r/aC3r
	 FNL5tzdVTBhPFUkSBUMew2Y88dhf5xmltNWYzT1rUsnapNAsIbseRCYKfRFAQ5+cHZc4Y
	 ++oF/y1Ta/5y4xREdeXV0oEErPOsGbEz0Kkt+drAcH9LDUq/GMrtTi4y1TL7UZ2TYUWJ2
	 NEYEeZ3KtdZYGk7kezhauXftsEj4KwiIzqGvCg6UY0keZ5qnJJ4d9AJ1mMO+JceULKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qeJfAbcW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792608115;
	bh=xHUq2GfEpOC5uRnZyO0OtJsMt6fLHGftPlB/0ud7UAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2Olcf+YvTVbwBGiaM1r6SPzr/zNa4T1w09m/j4Y0mQO6dkI/V7PkaJCja8cNo3I9
	 OE/BSm16uYIOCrPfWz0fw3TFnaq6Xd7yyPOeRBFHmHlrB1pOYs2iEgGVMnzI6JMEho
	 Uf9KCvLq1d+TD6kEp0+y2dQ6BDEUet+Gd67NoqEADlh5exfVcR6DEfuGYXRI0NH45f
	 3ebj+gSoAMQCWY8PugazuUFjYAJfWOuVBfUJBFngKO6yKIP02CvwEou3UFRHReVpap
	 NK8kz0RyKiYSpT0TbqoMIYRM4vBibrC0GQONEZ8R/15H16fpcpDrk4CNUn78p4HsR5
	 J8hB1ikYEqatg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F8CE6F4BC;
	Wed, 21 Oct 2026 18:41:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 227C8769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01B9D61777
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nuLKXbdj4BaQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 18:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 005546F4BC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792608112;
 b=PsSthiPtoca94e6LEwPrtAE5dFnLTzgan6un27iMY0Pxy5F56y46tsycMKmLntmm476l
 e+GaAL/bKB/ib+S8fA+Gzpkb0ibpR3YNahe77vwiSK4PvGr00Q72LMsjy4kAm9uJ0uksY
 /NbHNSdabFz9GjuZ6JY7YQWCas9rDGvYFOlJp5POe86kunpYwqaNBSYTzl/KC5yR1Of6j
 DuYO3tkC01YfUtUA5FRzgn9zq+5YsC3LeK2uYQmUk3Sb5gGHI7NBjWxiSorgGjqCCruZr
 p7pC14GzuDVnXs7mjfGCF3w/+lv2uZ5IoeQXy9N5j1n5XAGe1uVX91Frh1Cch0Y2F/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792608112;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=xHUq2GfEpOC5uRnZyO0OtJsMt6fLHGftPlB/0ud7UAw=;
 b=oQmqabqInWGVbjDsFprFCGCPcHvb/KFWwcwEwECa2oyWHWe9SgWgWmEKWOBASqPQWe4N
 tqQQE/ZXKd3PgA9hdGW7rbseYoCrprhV54BsqCPXD0MobYG16x/+QleViomOWHNmPx3Iv
 gwY1vb07p1KH+SoB9eUXzI8OPt0+7ynIQSo2+iKPgh4efR/l1frMnYAiKvUy+sXCwgpPZ
 ZA6DBc1bKgLR5HpDPpipKHK2ijI0LXqFEpU98yWbHZsQY1GX0lv/ZWm9vDIHmlH1PiKN7
 D3DWzi0gwXNclD/0mJUXnIJUPM1tA4vNUarxQXfW9Umud+copBSr+nkoP5Tz0LM+ZjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qeJfAbcW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qeJfAbcW
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 005546F4BC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:41:51 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1fe9efc0eso11925565e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792608110; x=1793212910;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xHUq2GfEpOC5uRnZyO0OtJsMt6fLHGftPlB/0ud7UAw=;
 b=qeJfAbcWQQaRraDYJ+cDEU3WPNwMwks9T7iB4AYX2HWaucI9+ZABaqvFSXBG95oy+F
 D3cDtfY7fxEEW4HWSRCH1w7J0YjJYFm7iUoL5V/A3xmhQ2JzMyxhonDat0oSwhufrNYm
 8XUCPQbHgpu7Y+EmZmbLXuBTZOoxAJt16IDKiY3AwF2dtHLJYjWjEv3Z37vlJWMdZCT3
 jVX6TXiuTWNiKwTq7f4HEShKozcXDvMkjZYqo3xmJCfbj0vwvMc3c+LHEjNj0OSVvVxy
 drCyuktd38BlD1Qhgl/3LJZjzWp2TD8U/J5kxBR38fwONrVynXsEOY/sOg5mkXt/83KU
 PT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792608110; x=1793212910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xHUq2GfEpOC5uRnZyO0OtJsMt6fLHGftPlB/0ud7UAw=;
 b=j1wFBPnYdbYK+LzUCqBZnDmQBjjy0fkpXTA0mwlq7chov329KNnubV2zQkSidvEp39
 j3Ot6vT1uEpdxvhYOzvr9rHqh0yPuWs75mhmVAKyKjhXTojdZr9LigYwH4XTBUTPh+Dw
 t/wZN5hgurmVvNXUl6GNkM3wFDc9x4GlYbql2sUZO+Fh9/SpywyGCeG28ZRU7Kz9p81x
 CLRT071yFwsw9axPaDjBR91eO7G1UxZ6CSadQ4o+vku71S03xhkZt40+TeC8x7D1s7c1
 xC2w7c4sXELIbEbRbhva0PqUQX9tMMeidLLpkN1BuaxsqT6qQCmjareGG/wOF8JtulC/
 PyUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByiIMwwJiNAqC5HugxRHKp1DySQRbnGvxw/FTmWNTOi/fse+IjK3g4BDNaIuUNEcnhUsKFqhYw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKMxXeKr5L93NZJiRakjQVTsiMSNzLptWwo2eiFOL0TJapBqn72
 IKc3UoSZjHJob9oanoOqsXZd+4z9/kMU6wAmBGHcJAXg0yw2LsN3wCTeKFjfsea2qq8=
X-Gm-Gg: AYBFou1i+ObSm2UxvKivjdEcpqeBI4vjYHyw0fSceatC/b/2qgCxnzTLRN+NS9cgawl
 jsOT/oxnKcijXQxJEnA/NqMvY6OW55BcPLwAZSBQo3enW0IEZvpo8Pn2vnghlzSkiBEBQ2g+RJT
 6lOZgDcHrKcbrizyvVdHtqZwbt+1t2UPH74kOg58T8hlTbwHoRAuz2IT8S7w/gHoYnfgIxEPKcv
 xe4wUvwcc2ISytqY9rbviKvy8CQRb3xQ1OnxJY66eKAFYCPdBK2/VV6VnzLHbkf3nUv2rfNZBAK
 hTLxn9DFp1TZS7fvptMxFw/myuIgfCQF7mchcjmd+28bP1cJLNyCCwGT/tH2Wber4v0LUQkB6v8
 dAfiXoIYBvIAXLsHSaa00Si00R8C/jEokW//ulG8RkWpjVMQShSDx+/r0ukbBlhRPW1ykFptiPJ
 5oS6fl/7qbCvSzfSOIIKHUSe0GyF1btjUwbewoXMe82XTSTpBv4xRmA0p9xGtK2Jkgil33+pP+r
 reQpWSiFSzlfKVtPd4ec4A79CjoVAMBseTBlFJqqkc/v76EGok9r7LjklvStQ==
X-Received: by 2002:a05:600c:19ca:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4a1fdb0175emr60729895e9.16.1792608109637; 
 Wed, 21 Oct 2026 11:41:49 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm69151605e9.0.2026.10.21.11.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:41:48 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
Date: Wed, 21 Oct 2026 20:41:47 +0200
Message-ID: <20261021184148.2433331-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e5c0aaef-aadc-4a1f-92b7-b75a7e9aad4c@mailbox.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-21, Marek Vasut wrote:
> Can we do this ?
>
> priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> /* Handle legacy DTs without dr_mode property, fall back to host */
> if (priv->dr_mode == USB_DR_MODE_UNKNOWN)
>    priv->dr_mode = USB_DR_MODE_HOST;

Yes, v8 does it this way.

Thanks,
Mehmet
