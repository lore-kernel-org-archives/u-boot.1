Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDEC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC1C40D25;
	Tue, 22 Sep 2026 15:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWO4OdlW10qK; Tue, 22 Sep 2026 15:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98EF1407FE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090105;
	b=seHONPhVJFOy8WDbf24sEqaebNBoX2BzbNttudVe4R9W42mW09DgEYWA86rhtg3TPvYn
	 MWKhNkjAaCto135iBKW70gEacFNMwcxQT1b46YLY4YEzF5z+cH9sW9ygzE6yAUZAz0d0h
	 5PhFiS4JCNjHkgUBdwO7vFzdVZdVvULguENmZGyKZgrwYtZY6/bKC5uyN0gl8GI9kq5MA
	 fqzR4OFztSFqohQIe3Ht85MrDYcjnVF5hr3Scpw/mXtlxs79kZlvFtB7rC+1xEXJetZdM
	 Wsj5ruMQqKkSY6kXKsnsdC1E8CGDp+K02OW0c5kwR4oYT+hKRPR5p1L1oDmM4WnOFwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
	b=Hl7a+BPF+NLnUqcMS1Oqnsm/c9ObZmp0TFDVmGoEbDeqPZRXMV5r1rv3u3RGd3b/MgIG
	 Rg1/btvBAEl7RqwbMUi7gzvH8COH34szGuYb7BvixhPozQOTEjnNKF1L6QFMfuJM/c7V5
	 Ch3vOK6yx/fuKH8G2YBfuGddCev8+WQwjzqzgx8gIWTKsw3cVWYU1Se9S90ZDFqZ3s3vR
	 NeXLBx11+KcesDaQFU4zZqPqHTun53Gb2kWTFW6+nUUuFtARd8RwAel+y9F1itsEbsxdp
	 8ZzerEyPiYYhQVI4b+Zirmby9RVEBsWy6xeCbM/yGY8UZFh2dvWWiUG1PQReMfcm9DQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090105;
	bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J9DD9ZmVpZoiaabvfHat6ljqu6S3iHA/5xfTGEPZs0ougDe6dvS8gm57X9XoZTrCp
	 tWzHa1oBWWpnbNzdeMWPkomcXs8taaMLU2C53z2hge5a4FOv6BKsTZQlhtYq7r0Re5
	 0wqSnI1nN0+ChvZtS3u/uHl7Y8LmhxzxM/e/Vq5J5EptdTFIu80BcgCE5g10gD8tmy
	 4v7DGdZzK3r0UAbciPmEk/hajHpO2aeRslVydpyNEQsd4AR3Hbdl2oRkFcLFodEUdh
	 fDOsIzj112i5fUGzuDFodroknLog6jcb2TE9dEu+lMzo9Q0YhJek2wtpaN/xJLo7LX
	 s5jol4+xWeSaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98EF1407FE;
	Tue, 22 Sep 2026 15:15:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEBE1D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D451A80EA9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxSq9-onL0WH for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EDF7480EA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.92
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790089532;
 b=VodZX/GDfLWh4DeVbZ2NR6zcrfWaEYZ9ENHzv1Fj2RtS/qS6ewMaxYhMyY0qu4tYAfJf
 H+Lm3LCx0kUgIWdJN+FD2OIm/xHkPYDgj09trv98ygyO5TSUJYw6mHa1zthDAzZJ+6WMO
 bxjVRr0dJbDm+vbBRHQucSzUSNa8Li5GguzFr1rUhpoIEESCUTL7fa84LUg+fj0CfE82n
 dx4Ogc636jTUPOnnpuUmodl57EOMGa6hLL5VrUH8EXJGokeb8uBrzW6smP+0lJNa2eLD9
 7TyjbYUt929aMx2G/ZXcdrGK7VfGjnvMuiZ4yOAxgR1q9IGM4enihvXDBOpQr80lapg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790089532;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
 b=LHGiXmrWfqTbxZ6JWVGhAfo3NaIOp91QNXvkwqdzc4AHt4rUBV4xhALhaGSmelPRoR/G
 I4QBs5iku1lxNvpXulDutf43hXqc8BEnr0WDRpd9nn5hj/bfgomycIslGW2dnK+/oo6EX
 i2euzVh2nQgvxNS2LU+/MlgRrJYtt3Q+Kz02p//6GE2awIx9q1UeWUIk0/s64RRSbjYX8
 rNpXNaDP4J/ArC/qMcQ2OY2CY6Xf3TXxVVoc2cR1PJC5me5xRyGrn+83R0D+G+r21rks4
 iGpBu9oKEv8OQ7KaguUrbTj5IjG5GSbVCjv6Fe/7ZuPHK6dGbnxI/NuanJ7jit1HAbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=EXHF+3Dq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 22 Sep 2026 15:05:31 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=EXHF+3Dq
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.92;
 helo=sender6-pp-o92.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com
 [165.173.180.92])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDF7480EA1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790089201; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HwfH44v3bW6B/m6OtQaYd9Gqn7edbm3BDs2zUApt0GywGQvHI69ZcU6f/6aAcT+oPc5/R+SRcw1sc0UPlRPklkxlbKzDXy6qX1i996pRBmZtAq17Jz7R4jJBZKGSDIN1xo0MpmQJ+JjBisl8Ur89jLNVEgfNF6MiLnvinV9n1p0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790089201;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=; 
 b=mOpUoHyzUSx5P47xmIBD+xsw/xTDwN9PXuUL9Zswx+IJgBm7fus4gYh4UM9YntIbhpCJ4d1qRt0d0EhNsG2N8d3YC0dOpEB6TtvhRRje5VXmLh9YtZxtVInmk7LWYPHnUTEUBe0ElSWiO9cOwHtx1ZEu7jsm1ag7uXMwGXjGOKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790089201; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
 b=EXHF+3DqIVNFqnDCvRUIgeSLm+rlstcUbwAwb2OD/roWoo/y3UW9Pr6X3Vv79vfM
 TUvf7N6gWv/4PW0SPdVKHQ/zQx14/BVYblWc7iukvB8FKwVjfiUqKRpGTn04tcnvuMu
 +v0oq8h67OSkYuoUN8AXg7ZEBlka5GfnEOMxWw4A=
Received: by smtp.zohomail.com with SMTPS id 1790089199399817.6574013085631;
 Tue, 22 Sep 2026 07:59:59 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 22:59:10 +0800
Subject: [PATCH v4 03/11] dt-bindings: soc: sophgo: add Milk-V Duo 256M board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-3-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227b9d41885b55dc3c7cd7bc00f0000eeafc21ef16861b004c602b5cb85f058aac2f6984ab44bc150:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 15:15:02 +0000
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

From: Chen-Yu Yeh <chenyou910331@gmail.com>

Add compatible string for the Milk-V Duo 256M board.

Signed-off-by: Chen-Yu Yeh <chenyou910331@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260725175346.139173-2-chenyou910331@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 06c236909705fcc92f59b0f2dd05a45b22902769 ]

(cherry picked from commit 39c49b7fc7a33b3af1c6fd80e599bd7d6db947be)
---
 dts/upstream/Bindings/soc/sophgo/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/Bindings/soc/sophgo/sophgo.yaml b/dts/upstream/Bindings/soc/sophgo/sophgo.yaml
index 1c502618de5..fcb1d905da7 100644
--- a/dts/upstream/Bindings/soc/sophgo/sophgo.yaml
+++ b/dts/upstream/Bindings/soc/sophgo/sophgo.yaml
@@ -31,6 +31,10 @@ properties:
               - milkv,duo-module-01-evb
           - const: milkv,duo-module-01
           - const: sophgo,sg2000
+      - items:
+          - enum:
+              - milkv,duo256m
+          - const: sophgo,sg2002
       - items:
           - enum:
               - sipeed,licheerv-nano-b

-- 
2.55.0

