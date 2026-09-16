Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B786C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 200644076A;
	Wed, 16 Sep 2026 13:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ffZ2gL_xWacJ; Wed, 16 Sep 2026 13:09:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3EB714072B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564159;
	b=abB+g2CHxlVI6aWXJTvlZC64NKiUVP0e/vJBN2QgTXOxo5xb20DMXlSRy6FMErjYAWsa
	 1gn0TgCfga1b3+dgzkM2aIBPMGDJqt8sXoAgvxk9rMq5O3sKMBEeej/tUQOBBR6ZRkRMp
	 I2xgmAa/H83m7GFiNjTvGjUsGSUXVtBFbKE0x0mk5sLC6vwgw2i5NdrNWNqQNVc8S+Rxi
	 4naRS0hu57UqgHJRqFycvBpGRYnTqJEyp5QY26bGxAW6ZOtREXMPVcqrLzjOc3T77iw2R
	 bOduZTzurFrT8VlhsWFcAZd8axYLvQuGfjhX+wqqQI4LinUq9WXg9xCaA5yqI21GKWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564159;
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
	b=n1sJvNdmh+LhyE+8pyLKzeIl/kTpEjfM7fD18F3GI5IiJfTGf/G+gG0mkqPmGXBS2Atw
	 FBgK3obJUfxNmfyKhcPIDk/C79JVtaKjZySYg6BKCm3wudd2fbxWnBuseO8T67/IzZmd+
	 /62xSKpl5lTG1npR5t/1eu+Px2WIs2tcf7TxSHu1aRTpOxkHlLnoAvcGrhw7jYiS7gDK4
	 cz1RVHIyvH60aeSlOmwQTO54imVX/wkDzqOA22U5wjtIXQVWgsJqOF53ODZHltQTDq5Mz
	 AuuD5mEajH+WpfogOheI2sJWID0a/EbMJ+WVYodIeuP5H4r9w8UhgKGF/0MPY1n9hgQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564159;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KfogSwj6+7aMThKiJh1ORBB0urizZZq9/8Ne+pZdZ7KA5GT0/K4BhdUhYP6UYmQUZ
	 q4oKk/iSD+axbjfANHPeKIcq7fPNweH6bLs/BaRP7BA6HHz9TFK33kvkt9cePad3N/
	 IKN91+F0UVhYAIK89fDBYJj7TlrS1tDawK2qDH9bkI2oh4e+eS8bSKFVKsypB7JwcD
	 atFCSTXJRaE9e4YAx3z+Ns3W5uv9kEI5EPqMwYiJDP4Z9bKvmeXkq6E8I1WmWlRVAo
	 ugN4ltNIFO808q1iiVgFypEMUPm8/gC7xRDXm0sbz4FZPMfXuAvjSCioQqinHH3a0z
	 c0GHX8HexnxoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EB714072B;
	Wed, 16 Sep 2026 13:09:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A86424D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C884607E9
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kXdImJctlKlK for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3924E6082B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::19"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562491;
 b=A0KAvxQVVrN9eEsiWjSidNubFM0wxsrYjnAOTupGULORG0YOE/ch7Z4aJghWDBtScRT9
 Pv3ZNwl1xrwFLSpcncQeOPPx+UKi8AwEWqLHZDDDuV5a30EVYk69NI3YqDPx1U5mXKm/k
 YgMyyUV3c7FlX+6hpfHZmr3cGunnaPYvpD2qUjzWR5VpgJcJuJ0+jJ9xtBV1ENzPNXuhh
 Lbi3l7TDv+s9lGfZKTtEfrWNd2i2oWrcfBJAdeWvgkho+s8xrz5X8XAN7T1+omOdgc1jb
 S/Upw7MSKNKCO486wm6WNVJpHC7/+NYzpM2CvC6T2+U3w+1DpRPOjEREsat5LVQVnrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562491;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=Hvhnocxq/GsBJgax/2k5SB3T7jtR3C47hIlu3NRWKC/Putd59DnQJwq1/+6/7yb/0C6j
 N5vXWPlfDlg5zdd5cOYkeILiDIpzTa4imgBYw4e0oc0H2cOmyegVY0kpvOGGLtsjAXqrG
 9Z3yvwVxhIv54GFgnRorXT2c4hW6XPi5bc/3hhWORphTBjjrIqROzSZsldnWbD9L27InI
 KutIPIdO473dnGWmbuv9kfqpDdUxSdL3qUAKGSMpxK9eocc3OcXW0XVn0biiRy5zqzeCm
 t3KtdnzmZST548b5lYG/7YYjLl0NLBLoQTJ0KLo9GH7oS5aHI0YFxA1VX/0sSKLvLvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fqO2Oft0; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::19; helo=mail-ed2-x19.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fqO2Oft0
Received: from mail-ed2-x19.google.com (mail-ed2-x19.google.com
 [IPv6:2a00:1450:4864:33::19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3924E6082B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:30 +0000 (UTC)
Received: by mail-ed2-x19.google.com with SMTP id
 4fb4d7f45d1cf-6a9c0e04b34so174553a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562489; x=1790167289;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=fqO2Oft0FigAyzFWS7ZCLF4o7VSIrGfr38CHQYFMWq0ybypS34bBiMkypqk2tVqUxl
 V+2SrnKA/PzDp1z8yMwilBMWgWNMHRk0EIOADgFlMQ/9ZZ293/G6s0iYA8BrC8h6xJ60
 DvBZxyUUxOYx9tdlXoRM0S1LBZ6kcSHUlibWCy2t4OdxCCFLNhnfp9Bqz8hpFJG8MTdt
 mC1OS3nG9SC7qH7+/rGc/VK8hEdfQpPobawaxeYKoCiRKBMHxIlOE5dzW12hD4C1TQQu
 gsf+aiA1Y2u4S8WdKnn3PDui8bxzzr0gizlQ4WLrpWPqAhC2JchzCvhnF7/M+hrZFS/7
 5MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562489; x=1790167289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=NazqRJ4454O2WuCIovP81XzTHhh9th3ubnNIjVFg2LK6UOJ/MqzGV5IquZBR3OfiqI
 3SZVSEyS+TmRn77OCXMmwHZnUdyR7LeA2gpOElFjqmO/vS+mEdCaPjaXSPhCwUNCjDB5
 mlbRIDzF8ag+8XoEIww7HGx359EUfllO8b9/KKY+jWNJuAMJX4/yvvQFmIPsT+7OUWdC
 3O5iya6SxJ/sEz8VLe/5uqb8pRVOpiQKSC76gHgPLSeb8vk9wtXejf4Lh7ymqMzg4mTt
 xbx04JgU8tHFbLQnzfJ3QgSi9QQ/7vwHVWGcylpQ1sDMzYLSRCwT8wrIGzPugibNbBpZ
 L8BQ==
X-Gm-Message-State: AFuF++n9PwHuryI0hZuDQGsAFQURJCsPxGUKd5iwa4p3Q1f2ljwWjQ4n
 1n2tjvjOLTwCoHaNC9P/NS8FNiq8LGDRiVrucjWJNB/95npNvIKkd8oFdnA9KlLkRnsCj2lfWaM
 /plUN
X-Gm-Gg: AYBFou27P9u1DQRr4BHeiCRgmMvbsRf4kUrrL5GBHXwNX7gtWROhM1DgMfDbbeA4+tj
 +0yipSB6jxvONhe8n9uHjjfNAudNFx8Xyb3k31aaj+KuSI1BAWACWRgXKPf1Hscg4Fb+y7fQ0s6
 UOmxCJzOjqT9XXDsjhvVpO+hIfOPuHtSngcCOtBrUXfZ93tdhUgD6F9dn5wYdnE0PGzIkvsqdWB
 zN4FuIbJs/v+ck7fsiQA4mz2yrXfkGYC7Ufa+qNg0XdP2yCZ4mWyTdW0AfpllL0sL8a9O7kxl/i
 B5piu52MagPqmYEbPCIRugkG9lXNvrvX7zrJjmEffHkaVVptbUMzpeur556tIhBhq4Uw4ztwJqp
 2u3Swuopfmb3QUUsMqYzxUIN9AlfnoYOI0cB9duSfzRGNLEnI/c8nEDO/FmBAkR897Wqx0JiuMg
 fVeV4FmZQVMQcca1ap3FIZ1jYntDxOmCAnOIYegWnvOCCLqjaOl+rumDxvMsKeSTTys4gvlalFO
 tIMXN1mR2xT/rwD/H+kA2o9RbgYgXAEFK31xCL4HReCqOA9kZoG5Krt
X-Received: by 2002:a05:6402:3213:b0:6a9:a816:ef32 with SMTP id
 4fb4d7f45d1cf-6aa2218005bmr2114307a12.0.1789562488791; 
 Wed, 16 Sep 2026 05:41:28 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 24/26] usb: mtu3: set endpoint capabilities
Date: Wed, 16 Sep 2026 14:38:24 +0200
Message-ID: <20260916123826.517181-25-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

