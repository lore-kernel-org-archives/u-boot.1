Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C24606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0gnoAqcH;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=if3tAqwg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A49C606EC;
	Wed,  4 Nov 2026 07:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KlXwi48v7tn; Wed,  4 Nov 2026 07:18:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88DD0605AD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776693;
	b=EOVZuVY2SUXMuD0IcrOKDzWtP1S3+SrA1p9pWA8u3v+9vmlVXPFvpytfIUOAd8464Khf
	 qCmlcP6OHBkf6bhjBODQlKhZZ7rJhUV+UOfepvRfBHVbWmrfVQq7nwa7WYas37yh+usqA
	 KCrOn76cO86HoYLWZufNmzKDIGK0Lx3eLPAqCLH7QK+XeovkdkcG4cwrJPjsb7HDI9/QT
	 +niQNqUoxVEDEj6aRjMtMjjDLDsw4JFH1D7MQwHAylJvc4dvzUm4nOEfV1CZmgkn4uS0q
	 DiGA6WBMC/BbmoX3sJ+P9y9fUanrmdE+ovE+nPxCzCTTSjRToeEwE3ogcKqMTgi4S2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AAxCLkbFGpQ1C8kRGb6gCRQXMCHQlg8CITuMGElEfZg=;
	b=NVYwYkkWFAmt2BUbIwVjz6hEDVGXtNIVGHr5TOJmuqsCmjyRMeH34Eakz0UVUi7qJ7h5
	 TfhGHtGwZViW+SiSIWDYGmMBB5/Rgsods69NiRViwcsx481KJyqpy+5hpMiowsTDJd5CV
	 ZiEijp1FMbTmmoJe220lbvYmDv0yiYw8Z0RHG5sFWOg1hrROekqdrOcAlswn2ki2+mVBm
	 jSrvcDByLGOSMOiGFMntVVgBoqscLpCZzARczPBw0U6w/s76CHbmfXybWD1PvtzduHBUZ
	 qpdv5TBX5dUDqXZGGdlGYQz3hIgZIv0AWbaS7VCyTQnVoiFul3cRTpdF0DCpteC92uw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776693;
	bh=AAxCLkbFGpQ1C8kRGb6gCRQXMCHQlg8CITuMGElEfZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0gnoAqcHfQT3ZPh/SqgYs/pTvG7zkbj8nKgUEo0CL4BYrkiKgROvzaJW2lY1yBRHc
	 ewQqEQi5Cw6PmDNKtWoENH1XIvwA5x+6vIn/ZICGeYaIsgxsfu+/wCDzL7ek3Yc2gD
	 Xs8g9hv5SV3X24dlbrc7BAZpzrFYpQlUwLMGAMVjjwEKF9CURfyCFz8dksppRzjh5N
	 LW52OAfu6Z32U9Y5lWivMD068QAGKQoZOKu5uu9vr9x/9DWK7llMCWusb/Wj7ujqHA
	 3fRQWPqqSDO29/RINOHYdh4dJ9Z8DSNfBeB6plTv81iS7MLVEpbbKcHiuWrywKp6kt
	 OOEZtuFdVcV2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88DD0605AD;
	Wed,  4 Nov 2026 07:18:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 614F7932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45FCF405CD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njPlMzD6ROeY for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37010405C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776691;
 b=XLfWzggks/H/S9vbHs7IvazE+qRVHGTwhD8k/VZpz39s+6jKP9lYHpRWugPHz2/EWBcb
 WQMruEHoGAPWEIfGbgKB6gcE591vytxNeeiVEIrufRhtYIHrVYAqoWZxXKDDAWBNZzbOj
 63+7ojVLE+k80fiYE1iQ+g3mErU40O9eFIknsSpF0Y3m/oeDPzv2/d3vuZSV6qdh8IFGu
 vjP4KWGVUfi39e0CYDAkd9AouTEfseN2FQ/BZ98PvQ4XpEwXJvUIYvBmQdW/AzSsTl2UF
 932/JY4XJ5OlpNFlDgCj8QnSxf47Vm/B+tAo7+bHeg8ByXJizN2OXFMwXAE5zSHznnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776691;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=AAxCLkbFGpQ1C8kRGb6gCRQXMCHQlg8CITuMGElEfZg=;
 b=DxJo2p6rhGSvrLwjGIBqG4swS8eNnAiR2SVVc+lWFG8hwmRyrgWRasgtWY2wThhLZboe
 q2AqQyJuvXs9qEGoVKlPy1DEqGb4fmistdyvBxDv4GY6SDhUCO059Ck633GsavamScHoA
 dukLxSAQgqJ3vOElNQFtefZ88M0/KhocBg2qC9KtfDlbFZ8+hbSyvlNXArX+tntnru6pq
 eDRmAeMPVyE7K/aehxigyhJkw6PtVLIlFooWa6LFmeKWAAZt0J/b19WyfE7GAZLxxvI/X
 CJNEDVeHbgZGQN/9rbJX4V3fcaKiBvwUmYv3+XO1ZBQxnPAocRyCBA9wIbvlMyT/vbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=if3tAqwg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=if3tAqwg
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37010405C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:10 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so2312405e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776689; x=1794381489;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AAxCLkbFGpQ1C8kRGb6gCRQXMCHQlg8CITuMGElEfZg=;
 b=if3tAqwgv+0X9wIDlyq2FrHaNo4xFZaxrr2Y/og2aVFFYKOGuQDhTQwYn3rh03YGbF
 pdTwIe3Hdy9DmqklVJ4N+ezMpnOWiUpDSFsYDJAbbqla/+fp2hdq/53cKc9GBHf1wzjL
 XGIwtD3OulczmKwPhOb8b2iVF7YWmCk1TYWIm1so9yekKrZQuieat/i3AT75dYsTFw72
 N5HSSJMteCOAVMqlBYTyspcqM/DyqKWcV7IJrhlub085+igIviygMZe4+q1draakYU2m
 glaDf5qfuIOFCg/P2f4erwcIv2f3i+KEr93xcm6QCky8SXv+irZtch7jPjuqzDkUpxQG
 bxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776689; x=1794381489;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AAxCLkbFGpQ1C8kRGb6gCRQXMCHQlg8CITuMGElEfZg=;
 b=F6jyXM0bVuWSppbfcBu9EjPGZSSoo0fBCWTsCw843uaRII5CQqWpAJkX68IA+k9NhW
 M3Y5z0SmXNaYcihkKN21MybWk8vc7ho1ZPyuKqfP+/0Ut6oc2YBRMdg1o9Pqw1zH232L
 7cE/tecUNpo63ukfZcvBC6KzY9OktVw3Gr2ly7c8MfH/sTGj7gmgEBvbb0tIwfgs0pVU
 xyhqSI5KYNhcKbeww6A/ybQvErhsAIh+/OrFkrOdSOdGjLzmHS5KjSxbEdFKjTZfQs8b
 mB7bs/NoqXkTm8v9yvGuL6glXvf8l4h/S+hatwv0f04wxhRc70rmJp9cpcpWKjij1y2F
 qbEg==
X-Gm-Message-State: APuU4Z8zq9zG1bl/fQceoKcbQ7WimL2EfthxH6V1NvciZ/J8R1e8m89L
 o8LVyR3n718qGtuNLGrK4JTwA/xU2Wby08Gp/MYzOJy+rsru9sW6AhXhUScUvxzl9J0=
X-Gm-Gg: AYBFou3kY9hoRTad7WTFq5mu+NvHChtyJJqREOrtZlEpJGhq276jglcjrX5JilQ+Yli
 7fq4cF58SXzkZDurWEKln6lhAdZPeA/VRJlb4dh3d7KIX9oGQVBp7n5XKPffG26S0WHmtJV6vK2
 DNGgzyTvTi4prvhGXH2t0/an7oxqueXecfknuReU5vlMMCUbKi5DPBHpRuSUwO5qLpgA7MGrW5t
 8IIz+VjUlN8/6qznKn8EweELLjoMo9f3lEV6dMG8Bd2CSiGu6XH/KA3V7NZ0YERx5k+6AT0pS3i
 b5tKFAqmk/9SSjMPwFKHeFn7nHR4elPdIjXe6nW8hxfUM3dLGSP9I79dtRwzUGTZDKzKyym/2CI
 NPectKDioI2wPXmUx7W4eFNJD9YFnouY8k/IDH4goU7ATKHWe+bviZVLt2hnODqViTd7ZcI6V+x
 vfinQhyLkqm5RGyjWYK34B/iUYCVxL1Jc/HsZs1B0COxofEwhhU8qoAKJNITVhr25rTji5wTPuF
 v6B0nUfWQ+5NxML2iOeRKzLBXiHlSkK4GxNHOZLL5/hTGeLdlmnj5YcFXtdOtb4Rqw7mLHkZ9no
 FRnDh/ukO+uFQwFlNp0r4ppm36t1W+o=
X-Received: by 2002:a05:600c:3554:b0:4a2:267:25b3 with SMTP id
 5b1f17b1804b1-4ac18c7461emr376299595e9.35.1793776688906; 
 Tue, 03 Nov 2026 23:18:08 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ecdasm52982115e9.5.2026.11.03.23.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:18:08 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 3/6] usb: gadget: f_sdp: write report 2 data only within a
 download
Date: Wed, 04 Nov 2026 07:18:07 +0000
Message-ID: <7caa5a02-b6b5-4666-a1f1-7aa8fb3ce10f@gmail.com>
In-Reply-To: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

sdp_setup() switches to SDP_STATE_RX_FILE_DATA_BUSY on every report 2
SET_REPORT, whatever the state, and sdp_rx_data_complete() then copies
the packet to dnl_address. Two things follow:

- a report 2 sent outside a download (after the previous WRITE_FILE
  completed, or during a DCD_WRITE) is still copied to dnl_address,
  where the last download ended, or wherever an earlier command left
  it;
- the last packet of a download is copied whole, padding included,
  although dnl_bytes_remaining is clamped to zero: up to a packet past
  the length the host announced in WRITE_FILE.

Accept report 2 only while a WRITE_FILE or DCD_WRITE expects data and
stall it otherwise, and copy no more than the bytes remaining. DCD data
is still consumed without being written, as the DCD commands are
stubs. The host tools (imx_usb_loader, uuu) send data only after the
command and pad only the last packet, so their flows are unchanged.

Fixes: 5661f08a7144 ("usb: gadget: add SDP driver")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/gadget/f_sdp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 20de9507d36..9af411f16ec 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -402,12 +402,11 @@ static void sdp_rx_data_complete(struct usb_ep *ep, struct usb_request *req)
 		/*
 		 * Some USB stacks require to send a complete buffer as
 		 * specified in the HID descriptor. This leads to longer
-		 * transfers than the file length, no problem for us.
+		 * transfers than the file length: drop the padding.
 		 */
-		sdp->dnl_bytes_remaining = 0;
-	} else {
-		sdp->dnl_bytes_remaining -= datalen;
+		datalen = sdp->dnl_bytes_remaining;
 	}
+	sdp->dnl_bytes_remaining -= datalen;
 
 	if (sdp->state == SDP_STATE_RX_FILE_DATA_BUSY) {
 		memcpy(sdp_ptr(sdp->dnl_address), req->buf + 1, datalen);
@@ -415,7 +414,9 @@ static void sdp_rx_data_complete(struct usb_ep *ep, struct usb_request *req)
 	}
 
 	if (sdp->dnl_bytes_remaining) {
-		sdp->state = SDP_STATE_RX_FILE_DATA;
+		/* DCD data is consumed, never written to dnl_address */
+		if (sdp->state == SDP_STATE_RX_FILE_DATA_BUSY)
+			sdp->state = SDP_STATE_RX_FILE_DATA;
 		return;
 	}
 
@@ -509,9 +510,15 @@ static int sdp_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 				sdp_func->ep_int_enable = false;
 				break;
 			case 2:
+				/* Data only follows a WRITE_FILE or DCD_WRITE */
+				if (sdp_func->state == SDP_STATE_RX_FILE_DATA ||
+				    sdp_func->state == SDP_STATE_RX_FILE_DATA_BUSY)
+					sdp_func->state = SDP_STATE_RX_FILE_DATA_BUSY;
+				else if (sdp_func->state != SDP_STATE_RX_DCD_DATA)
+					return -EOPNOTSUPP;
+
 				value = len;
 				req->complete = sdp_rx_data_complete;
-				sdp_func->state = SDP_STATE_RX_FILE_DATA_BUSY;
 				break;
 			}
 		}
