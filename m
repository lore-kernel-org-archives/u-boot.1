Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C171CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D877D4061F;
	Mon, 12 Oct 2026 22:28:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82_k5YLEtKUP; Mon, 12 Oct 2026 22:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B801540634
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844095;
	b=OsIrA4wbOyxujyPbdVtAsObe9Zi0vUPZNZkfHJ7qLFa6GRJZy3sNUga5qcD0iLvMR3mM
	 ZJ2C2Cif3Ekvav+3E0qTotv3wisENKfoO0NFmmrL0X++/2I4beT/l+rHzWl2f7wXR4MyN
	 Uz2azdunJfeykd1Y5Dw2B1QvoWPtsHr549tvHkETDjMgtAWXk8XCxIT1Oi9fM6g1uWswS
	 f2DlSBuFNJhQI7JsPqxErOdEM2W4UUyCXTyYiPLnkURggU/VMdh4NXYK7pugydPyd15gc
	 inI6XkZvRV8NJRd6GIM/S5G3v/XyOHh01+obywNZLz2YOY5yHwPFNaHi0TIOWsNMcJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=kqr8MX095Umam27PZh3ITYYKBc1KmsyzMKUBPlzF/ig=;
	b=Z6nqVewViHYnwIonjdjREGBJg58BgBmcmOTz7GpS4CkwPk94qNZ0l6FUMEeYh6mxXAwo
	 DKcIONZw1abCCHWZk3duJTlFEP6bq3KA70WywNvL3LfE6PI6EAgRe9D9Uq7CAHW55jfZ/
	 xFC3VGUB5zKfvsQ54c8JmcgElIGLjpu+GrZs5DkDplKXSyTZ+A3i5D756zPepxIWDizqN
	 KSCqRxhf9+a81h0QHMD/EDzWvCLNVcti52TPrgvNTxfMRcbkyK+rjw11/CUtANXue2M0Y
	 3WX6F93A5WCWtW7NPcQ1KpnqxLlGaq7K5GfUZwRRn1msmTP0S2CNSQu8e2Qemg50hvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844095;
	bh=kqr8MX095Umam27PZh3ITYYKBc1KmsyzMKUBPlzF/ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M4ERLPkqlyGTCFv90dASyMhrxfKqFg4NQlnIqx5IJSaRDJfs8nTsu8tvIvGzwzjCn
	 Xh+BMh4rhiCcQ0PoF2JaxSYhHDa1aeaNtf2w6bFQtDHqh2B+mYHi+9B6ZTrY0Mnosg
	 GA+xwtpWR0zRBKfwmGyEWpDr0KHyKIu64PFL7ALDF+F/XJ2zK6kYtYaOOZe2e6t/Vr
	 OICAqdHpDLp0+zXiLr3JJrErg+UFhHTmPdeTIYGktq+DQR4JMYDE5IEzlzUF6wROOt
	 Ijes5cY6hfeouxaG0IhWrTmKRZuSR1d1VUmOCUw6XWEKtQ7tiuvhaQqLogHGoWflj9
	 tNj7F9N76+DoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B801540634;
	Mon, 12 Oct 2026 22:28:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E67D731
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0039D606F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IYTgonIP5tma for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44705605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844088;
 b=a3Ltp1rcAz9EgPO0j4EVozaCePHAaHYl701LqeNIcyZD42u3br5rOZy1lbRBQ4e1YTuf
 EdH0F+n9RJaqrLLPbopnbRcGn0aeyfvRhRfELOLzF7UfnU2XoNAgQ6jdP7lTdIxXrV1jN
 804Y8Q/njnW8dxfH1snZJsDT0sSWlz7s8tYR49wSWZBrvK1mPIaMXU7G36sieJ4Ok44Xd
 upsZc+gxpmkJOn2igdKd3YvPJSy/70GZoZ8t5EwDgK5K5vrdx9a/xEOfx7iShydg+GDqj
 BodU0pAMQc4WuB3JGKfFx/weWyCmkXXHq0ZAmpHPMrsGZBgXS5FdIukeabiJZkcMwbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844088;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=kqr8MX095Umam27PZh3ITYYKBc1KmsyzMKUBPlzF/ig=;
 b=avIMY8UFy9y5Pu+XxYnMj6h+AhzB9ejeMLjCqMpCowYMh93yyVUvChT8dEPcm3yVHjT3
 ZbP2tZ+cZ2PZ3ASqj6tcqqFtz9qdUmVMEkuqkkytnrxz7iFbR4O1xcxc6NaE2zGt5A11n
 zCYYuO+Mn6Lr0pkMXjlL2dTSYG9GO7lCtXPjZduBjojNp2/LyCpf6efDK3fa/2YHqTo9e
 wBbyoI6Vq5bas3AR5hbDXjEJWKRgHfVdp+I2xQok8PuVSyzmSn9p1g77J91FkYwt0Eoml
 Lj6w6atG+v1oqNMQ4ETBKHQp4aUqzpRzjtEIi6bLuIOMMD+UbU0VqsoWwcROxm2wPBA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZrWoCSoA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZrWoCSoA
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44705605D9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:07 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6de3360d905so2052232eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844087; x=1792448887;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kqr8MX095Umam27PZh3ITYYKBc1KmsyzMKUBPlzF/ig=;
 b=ZrWoCSoAeZbVWJXKerpH/ulHBT/Di1VAcI7e591+xozuHFqHGGRe1gFZGwjYxdc1S4
 y1+LxneL5VpuB8g6SZi3Erkh44TQiUszHBmYP2v1YX7bRWhKifiAdI3QFaZfFZkUE434
 mSEGbvUlB1t42V/dQLaBNZO+XhAbBxOUXGu/1cG0aVlcChzlYrJHiBx6kU7zDACpNpGp
 iuoW9KOOUln66iDfEPW4kaK/CwSs2mWXd6L9kiDeMB6kE3OtLPKwcrb8yOJz4Ei2GoyK
 eA7qncfWwfKhuiLdic12uwh5GQ3eRwCl7Sw0Xn01YYLgTuVe1UpGn51ZqnjsBIc8LvXq
 56WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844087; x=1792448887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kqr8MX095Umam27PZh3ITYYKBc1KmsyzMKUBPlzF/ig=;
 b=ioJj3+Bj3Kn+mAMyRAeM90b3OBML0kNNlPUk7wiNkyAB+66QL/z7jo7nhqyfA+H4xf
 WzPevSwYHALjWzBlzb+EjClZ52FklacanAMNMXmPNGZ7Q/PzFloTMyqXETJJf2TrzbHg
 zfZnxTFkImts95mHpLt1CgewfoHR0rthpEUGwuqyVXPxvFi3vZJ8gMz7Rarer9ZcsOEU
 TnO/JoNtg7I7dvXLcmIpbLJNTvxoDZ0Yz1opETNUIlIHIPoK6Vijh3uOQ2P4OFi9FYOJ
 3aFNpW+dIEwzN+XrSlFcFLwR2SzsRpeRIsjbu+Fj74izPcAwpAlJ5tumUp+3/4HXbrfe
 Pnyg==
X-Gm-Message-State: AFq9FYIH5/0FrGPZH5smHW/wsyBzUb097ozyOzjP4HE+fJ+AzJ3Mfo38
 MjvA1UWbBiXeX96iBCyl8PJoOK5QerxnANeSFfjDtQk6ty/CaaiyaovzSBcVHg==
X-Gm-Gg: AYBFou0Lil9j7c2vdOTafb6p/kmU8xOxzPhzRIcdEWeOaNViSazhaF/BgOkQh/vIkhX
 oj3dx5H8g+nbuP/9B0qr4babD5eCliy1KYfA1qM8PJaAT3HS8bKg9Vq7V6GyOck7+9dpehOnNsJ
 a27xu/zFgPMFjT0EUHQs1gE8h1sjBQr68xbqo7SMB+6KBYclve87EZOXHZZS4LpvOuzXt1o0bHE
 8I+0fOciNiCOwNlFbxFfApHVFswYBBBUZPbAfhkJ98q6DJOygKP8kNaZiQ0HEVi3udT6Vc/JC6N
 keRKh7eBtsXnwUXKSg5lvRoNZrrC1SNsatj8dcRf8/Tprlu//dJJ4w5gVnSV1X5u5GjKoOQsg1h
 rxjXsFD5puzHhma/lI+zc/Ll4Uc2o/RWUBgDjs5nwG/KonJQQOw0tb3pYArpTTcmedN9a98s9+x
 7dsnnuHbJKa1YOfnTzmiBGz6Qr8/Dhi9EVum5uafXDriQClq5zkZn6Tr/kS2tgLFbMm//+HCD2N
 0aDcnnSwxmlPNanmxKOjus+6wg9slLugPo5kDAtPtRdIwdEmrpHvpKzVg8r3dFcZ5UURa3HNKA1
 0KJoAsnN74z3KzH+rloRarCWv0egGj/AMq4wFfJHY4AG+KKr1Dq+bMopN8ADB6Adw+TBj1rNAnE
 W8rv6TL2EvINIHvdGamMjlA==
X-Received: by 2002:a05:6820:1992:b0:6d8:6049:124f with SMTP id
 006d021491bc7-6ef0d33068fmr7784391eaf.17.1791844086985; 
 Mon, 12 Oct 2026 15:28:06 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:28:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:28:01 -0600
Subject: [PATCH v2 6/8] net: tsec: return -EAGAIN for empty receives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-6-c6a20425c15d@gmail.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

tsec_recv() returns -1 when the receive descriptor is empty.
net_lwip_rx() only treats -EAGAIN as a non-fatal empty receive, so DHCP
can abort on an idle poll now that it checks net_lwip_poll().

Set the return value to -EAGAIN for an empty descriptor. Keep the
IEVENT_BSY receiver restart after that check, and preserve the separate
error return and descriptor rearming for a malformed frame.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/tsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tsec.c b/drivers/net/tsec.c
index d03368b9408..b6819fd5317 100644
--- a/drivers/net/tsec.c
+++ b/drivers/net/tsec.c
@@ -335,6 +335,8 @@ static int tsec_recv(struct udevice *dev, int flags, uchar **packetp)
 			/* Rearm the packet buffer */
 			tsec_free_pkt(dev, NULL, 0);
 		}
+	} else {
+		ret = -EAGAIN;
 	}
 
 	if (in_be32(&regs->ievent) & IEVENT_BSY) {

-- 
2.53.0

