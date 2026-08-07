Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE87C5AC82
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DA9060905;
	Fri,  7 Aug 2026 16:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6gRSZv-XNECZ; Fri,  7 Aug 2026 16:12:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D17260684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119172;
	bh=4jdg9ujw06xn6Ap7jZs7hcONdqjCly66sfM9bZgjMDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWzjv723rTqfECoH39A8oyoSkPc0Y4jKqefU8GfrBOxWqaQvY1vhr75wl80I9IR+0
	 UQ2zQxazIRL8uVMPXoB7gLH2dt0scUDchMgoPuBHfGR54aPOgrLxZA3IRlxZVxr0N/
	 jqEX9N5M3myw8DVKc7oXJl1ZfXvXf0nejopmHgNc60tQy8KODR9huaMFTsJB0ZPZlm
	 X/1Vq7vl+iLd2XSebjq6AgQE62LaqycmLV78ketV6QeSf8khGOe2eGJ4uN0mtgdokK
	 AB5tlxRyNEfpCGVUIgcZpmuNgZGR7E7X9HxQyPS/1oJErDpdK680kkuHTRDqRE8wkE
	 G2WzjT7+HigkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D17260684;
	Fri,  7 Aug 2026 16:12:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F1E4392
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9187140269
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKYElqE9JKbe for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5BE1540074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BE1540074
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BE1540074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:43 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so377854066b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786114361; x=1786719161;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4jdg9ujw06xn6Ap7jZs7hcONdqjCly66sfM9bZgjMDc=;
 b=kPnsy70G4p8rzVfkKesKU9Lqvw/khaRHGq4ZoGeKZTfl/XQpKIELY8p+K+52pYlRbA
 RF6mEzmdgOhDu21qxxdLJy3dy6BsemJfGBNPKto10Bam0gvcoocZDVAIBOcbudCpvtlf
 xy6EWC2gDnQLY5+sipr77f5h5kF/Ejw8mILgaoaclsYySU/G/pvSfI18pk6w+Y69ka+D
 2sSNCtmJNen/VDWQsdb4GubjvTMGTfSf+ESdSQsSHqqJhzXh6VIMvSzAJUt13MFXosBt
 EOIQhdQAd5OzCyhf5zCqzECHcfoO8R7eU9vSdEo5WMMXC9Tu3Y23GwqXuhhUKGKQcvkm
 S5qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkIHTCKqirYu/T4yLqXyy4L+LNjJBWFguHuyPHQS68evXAbiDpbyJjyS7uFxfS9U7lXnUPrNI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxyxzq6Jrk5dteV0TrpOY8zAhluh5OG0ph+MlLUclq65Kaj3weH
 DJBpXdxk49JOcyFKh6GEdHZh1rArOoOrI3ZjShe4ZNoHUNMF1htUv0L0zPg2lJEdwNBec2WZbe3
 fjMfv3ds=
X-Gm-Gg: AR+sD11NJSdUAIkLAev1xtV7DaX411al2wRjuVUsYckXDAXN9rGHzOseKbVEK7zbALe
 jC7RKocfTPNP6UBYIKeCCfUuOYhfeXJ602oDOedn9Cy1x6vwMO2Oo7QtJ4E2zAxuccXq1F4g5BH
 mXdOOMwHS7ZmYjOgJkWkecrniRwOubwGf/S2D2vkvhl882y9SJRSV9/04XGi2psyVxnPuYj491f
 QBedM7ys3c9CGbBijtt09XVK92KtTwWSFyf2vp+xZjnZqmB8ctmmhbj8tzUmWpJnnHjW+JALQGs
 B3B8Ni90NcL08O2GxGVLywQY5ahKpkh0PDcBPXVt5no91SLH03/1EeIgiUbmRYvmUNyQbKuK6Ns
 +evi5HHkMcR1Vvf9n/nyPDwmtyxpP3y68fZowYlGEQhyKunZitdHFprcogbOhg1cJa+eFaMQrbP
 JgrCePigZ3UfERR+pp26d8vhorDcRgBf3RyOVzN0WSV4sB69LR13DDIAysXVZ/+uLjQ/+FAsI88
 3GhJsIPnObLkbNAShjygMGUIyaG1NmC1dB1Ojec/xR7OdN9HX+PjasCPJnukGoW
X-Received: by 2002:a17:907:980c:b0:c20:3679:a2e6 with SMTP id
 a640c23a62f3a-c2039b4bf40mr1152355866b.10.1786114361196; 
 Fri, 07 Aug 2026 07:52:41 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0050294ea7756f18f0.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:5029:4ea7:756f:18f0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080cc3963sm62218566b.50.2026.08.07.07.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:52:40 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Fri, 07 Aug 2026 16:52:21 +0200
Subject: [PATCH 1/2] net: dhcp6: prevent an infinite loop parsing IA
 options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-poc-dhcp6-ia-loop-v1-1-9d3fd3171c59@byteray.co.uk>
References: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
In-Reply-To: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sean Edmond <seanedmond@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Francois Berder <fberder@outlook.fr>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 07 Aug 2026 16:12:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786114361; x=1786719161;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4jdg9ujw06xn6Ap7jZs7hcONdqjCly66sfM9bZgjMDc=;
 b=elfCSX9JkwstdXU6ppfUHV8owXKvnWneEYB9b6H1+Y9UF5pkMSTimMj9L3Ot5VaQGV
 9FDxeLtbIOEsswY6j4spI/7oz/P8T3RXHwoB5baYdgIEKLR1YAMKMwIUnOQiTaWB0WSY
 17sKwXXV+k9dsSacoxNU1Aiz5c+9Qri65p71nGoAsb2ZUBqA4i7xp5BIIS/LUGhcqyWe
 hWCOAfTyzb+zZID2/RtRgiFhxWeIKrpsT6H9Z0Fi9RgB/Rxx3SFfiDdjZEjBzvZrmxtb
 4jXGzy9Ay5VnHBUIMqXzS3LJpBJpZOPxB9DzI5mrHwJBhWj6tIGsIvrB5pe8DcDv6bXW
 Z9qw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=elfCSX9J
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

dhcp6_parse_ia_options() walks the sub-options encapsulated in a received
IA_NA / IA_TA option and advances its cursor by the sub-option's declared
length alone. A sub-option with a length of zero never advances the
cursor, so the while loop spins forever and the DHCPv6 client hangs. The
advance also omits the sub-option header, so it is short even for
well-formed options.

An attacker on the local link able to answer the client's SOLICIT during
a netboot can send an ADVERTISE whose IA_NA carries a zero-length
encapsulated sub-option and hang the client; the IA_ID it has to match is
observable in the client's SOLICIT.

Advance the cursor by the sub-option header size plus its length so every
iteration makes forward progress and the walk matches the option layout.

Fixes: a0245818f7f8 ("net: dhcp6: Add DHCPv6 (DHCP for IPv6)")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/dhcpv6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 640f089a2e1..1e92d744615 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -285,7 +285,8 @@ static void dhcp6_parse_ia_options(struct dhcp6_option_hdr *ia_ptr, uchar *ia_op
 			break;
 		}
 
-		ia_option_ptr += ntohs(((struct dhcp6_option_hdr *)ia_option_ptr)->option_len);
+		ia_option_ptr += sizeof(struct dhcp6_option_hdr) +
+				 ntohs(((struct dhcp6_option_hdr *)ia_option_ptr)->option_len);
 	}
 }
 

-- 
2.43.0

