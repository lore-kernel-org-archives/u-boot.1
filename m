Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70660C79FBE
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 341E940737;
	Wed,  9 Sep 2026 12:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpitx4alXV6v; Wed,  9 Sep 2026 12:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EFE4B407E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957998;
	b=mNPm3aNqMrTfjRABZY1/Zn07WHkPJEMkT38vlnCkCG5+Xjf9NCkDMkAM7UhmaIo40yv6
	 YQz0ygmr8G9nJGlzoQYvOY2pJAZonqnMOiBznIdgcTJVW+rmuPndOeS9V9BywXwdrL3VH
	 A3JEnxz7ALedyuh6tXz6uxc/H7fLZ1qpMH/XL5HwB894uE7hA6Rbn3cTi5JKnjmkDbTs3
	 QlKHKZSoXCSfXxE1CDcYEkb03ecg6H3Wv6QOzQJDOFYGtNlkDvkqtSW+gdBkLfoRultqj
	 id+pp6cD6dAVgjJ5JO9g8S5L5r0b/NjaVoYuxBGtImqModNgsqs91xpl5yf/Bg9bEyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	b=n9/8WQj5inuOJ2CZrwkJZEVN9h0HwweuZI55RI5LiT7N/7AVMUsT/SOUKElj9xO5gIqV
	 BPY0kPt0waHdOSmO52Ng526WTPgenJWRhnumf8CwxrLbifj+5YZwQD9CMd9tlRc8JUBDX
	 1h5jv4lW50C8bOffsfpmEDmZ2+bi2NElLjIUkvmW4WlP0RuXkyM/1+EHxQqXgLJGIU2SJ
	 6bra6ZnAhS9Mql2mnvme7FozB+bwyuP3MqSIgpEksVWmb+g8iWW4tfHEKMunHXmWxW42L
	 0MP4EWRL/1V9T11o7xHLC8p3NxMgQIzfFXUqX1go6U2T51CHfQq6w/V6dfgUW0UQdHQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957998;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nN3fVuW0FLMTT9GgZIK7YQZozMJ26IcVGT5LLMXukD7J0mPh94OyzUGq4kBSxVnBo
	 TjFAP7hWNV7INf4DkouISb5sHrwIjP3k9ahOdHGbP0oOZ30Zkdvw8hilMZoQSMycPz
	 H1dcMabTfaPp+EWzBLkakSTU+cujRPSLzz7EodyAuUJMcLcXuN0JAd5j0VLbgueafJ
	 hYYNtb1VE/MHFsg5uXDTr4XbP2LYXegQXSneojVbwuXKZtWM8JJbiM/A4WN2kultVJ
	 hODsba2xEMjDd1qgUIXFUu0LWz1AIZ6wutQV1hqDmwv27wDrOK6a7m5Vse686OcCKB
	 fV7UyZHwk7nrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFE4B407E3;
	Wed,  9 Sep 2026 12:46:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A00E701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57B6360639
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxPxsWt7z1pr for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 14806606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944008;
 b=qiMsibRNiQP0515mFH7Y99mXr3YZfgOjs/YsMrb1M/VW0btUML3PzIEtGhxz1basGP+U
 MAbXUJccBvTjNEnn1TcQ9Kja3PCsM2ZisIFdBJzm1K0u1ixCmSimx+paj+XYc/cvp73Rd
 RNsl68HUxZjzliSsie4DsfKu9Us3sdnv8b5iNEkKwblRtI+nF52DaCHgpZ8EN1F8kCB87
 hggUkj/0iO5vlaH6/M8NYqjX+3tIMUzefk5ct1EDZt3zMR6c8POqyN9r6OJqfZBgp+/bB
 uoXs/i2MAl2x4wUWms5DqzGN2EYh8MULkvoL5dC3jcCQXmC6+/YoP6Rm4NFNPE7wotQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944008;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=l3IzBtsTl28Pi87Ykqn9ex7zPOz4hv8WPG4ME7gZUr0p/3K0vYiqzDDkeNKb/N5RBApS
 QaTA4ik5e+/mR/Hnc4lg4wrZT20xacAqmNl3xv/b/frFfa/YxFmulokT5jZrFSh78ucfd
 kO+BxoAAhv4w1CBExqiM+snClVma/Dk+p7rPbU+SH9cK+nvEzJGGwoUaIml0Ko/Llj2Ou
 i9AHs+7DNmLgiiT02CL7Vb3iPjhEHE76Z5RZ3JQq1YSzEQtZy8PQt4EP1zum/SMWdViMi
 aKFhzbApKLsuHh1/N7f0bZI5rSc7GuQyp9uZ9tsbUzRBJPgsMAcLFt5BXKMBJpnI31g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dwUnchgX; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dwUnchgX
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14806606D3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:27 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29385fb97cso4207666b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788944006; x=1789548806;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=dwUnchgXmoOqTSNdTyqsTeDa0k6GR/MwJ7ufnOXCJAbbJ7kBr3LScohd8+Llgz9x36
 y0QWxHRb96/RSgfpYbHBlaQ6FFMC4iLwi87V9uIW8Sz1KoBLqlyB6Bm8zu+wC1BsEEk9
 bvTSIBtlMBpurxB9GQ6Y4og26IzjlEFoieZieLUayr4h/pJN/s59WN/k433D92eHfBiz
 pxg6k7Un+Iw2AHU3xfXR+dO/EdBIy/mSrFY9H3BcKSzKTI7vxvEJcQ7LHC5AMnkhmOWX
 HqRNrPyaKnKGBX+n/Zia3JFtANtKiH6vfiXFPMccBB3/MvlPsSCjIhCXWxZ2npnSnYOz
 59Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944006; x=1789548806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=kYwaz/jBXpGnrr6XVP6m6HQ6WZVz1bgHDs8vUzJzdzRt412vwFiU6UXQeOM5i1ZXJk
 JEh/wzuRimPdY48ZeCZHMea/QD9liirNv+HBMQZNBmFMlVWeKOKM9zh+xxZ1X7MElNCJ
 GS4qZzkmwtbTqVpxSvNgHP4KaFqovaAQxbBNiWY2jXO/6HX8xbSvORNrrpcIDrkY1siI
 rtE4/FgfLD98amrwlgLGkcoFK1BKq9vhGajUOjCtcmM8SoBkGT8w9SgjP7e//4K7fKqu
 KE4EkObt4nv3Sa+rzxbvXD7HgZPMJRR21/lKvnk89hEuTtE6/9wLudO9BEiQYnQmG2pv
 YqhA==
X-Gm-Message-State: AFuF++kA9HckXRBxdGxBzLpgt1lkT8y6eAboNfghYfyBEw2OMo63sJ2C
 kTHbKnTdGZBjHaZ+zNgX0MmkOJuusFR04HnuLroc3SEvNyv7Ywzcr0vUaKJrTxXmfh2N33Vj8mT
 4ymp+
X-Gm-Gg: AYBFou17XuhL2vC4D6hNWzdMEeq85TyFdMDvKdW/sW9m3WaHHjeWnSMuxuV7A/1fjwq
 vq1cZw40vCE+1aEUCOT+PXdpiCRnlEWef2xK2eeJ73dyiFpRSLuixmf2G+8+GCzNRM7N0rQpNxb
 E0qAk33yUz95/ejCtG0au5BFKSdWgd9RIoVcHHP1PDfBwYFYtVEQZy3GNJV7JC+1i+yvXuTdvgV
 waHfik277Gjq8vEfLWEXFj5ZLhSyEzxe0vJLRKCebSuOz66x+er9+6y7X5Hj7p06IGiiDIarqkB
 +o9mcyjLe5k0Il8lxw9h97yIx4AeW2AzFhXuwxkfVDFahlHU0zc5T8XMpVtxlOQoVyHpw6SqSti
 V14qL9aBk9Co9mc7CvvAPVQVvIWrUv3UvHeIQ4ink5WbrxJwZjILuDWsWqFhBqZyawryfq5Sz4j
 WlhvMbQnlYI1zQ7n9z97+isA6zTHu4AMJLWft9/KDqJF/u9cxePgLIXs2t5wDHPnQ0Hp3K//MeF
 DJtRoelTAcoBqIcCWOek/5Likxeuo4y
X-Received: by 2002:a17:907:d2a:b0:c26:2204:da6c with SMTP id
 a640c23a62f3a-c26250342e2mr1093917966b.2.1788944005887; 
 Wed, 09 Sep 2026 01:53:25 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm557381266b.19.2026.09.09.01.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:53:25 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v8 23/25] usb: mtu3: set endpoint capabilities
Date: Wed,  9 Sep 2026 10:50:13 +0200
Message-ID: <20260909085015.2480097-24-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

mtu3 already uses usb_ep_set_maxpacket_limit(), so only the caps field is
missing. Without it usb_gadget_ep_match_desc() finds no endpoint after
the dwc3 resync.

Set the capabilities like the kernel driver does.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da633faae7b2..f209bf47d073 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -591,10 +591,20 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 	/* initialize maxpacket as SS */
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_HS_MAXP);
+		mep->ep.caps.type_control = 1;
+		mep->ep.caps.dir_in = 1;
+		mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep0_ops;
 		mtu->g.ep0 = &mep->ep;
 	} else {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_SS_MAXP);
+		mep->ep.caps.type_iso = 1;
+		mep->ep.caps.type_bulk = 1;
+		mep->ep.caps.type_int = 1;
+		if (is_in)
+			mep->ep.caps.dir_in = 1;
+		else
+			mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep_ops;
 		list_add_tail(&mep->ep.ep_list, &mtu->g.ep_list);
 	}
-- 
2.53.0

