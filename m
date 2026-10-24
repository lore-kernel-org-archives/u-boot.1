Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F20606A320
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B3V3VR3h;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g/jvgbU7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EFEC60725;
	Sat, 24 Oct 2026 10:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6cGivvLQ3Sg; Sat, 24 Oct 2026 10:12:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87E0660739
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836770;
	b=Eme7VweqSG/MEAlqLFQINcEofKbECFnVISw0CPnBxJMfmSRvJyEoavgn/Ep/gP4/0hxa
	 dRWTm6AyvMLkGBvP2mWCO4sgec+vru/78qXpjXxRudoErV3IvY9Kk48fOVPwp/X7njAIb
	 k0CSEOCYI2p/S/Qb4gQY4Ih5rwjHN15K1397CPPU9XZ0c+jz4bIiNqWAY9vAg2nLKL6Y0
	 YL3eSu3CqWBiucl+5DvB4HUopOAC5opBKGyacb+Yxysr28UDUmE+5WPB4m3tIwVwLyZXP
	 +91Bvl/NR0UjpbNpC2P/bmv1A2BVWbO1wyrN3VX6FesIih/9MzWPsNBdCOz2S4SD0oA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s7pUc6CuM1fj6hUMbS6E0h3cbinHYq7YhOfXH6HnVoQ=;
	b=svO82WeF0yaHK/TQ9PZZdtQFGXzbLvhLth7j91ONv7P8fqsOVP6XXGP/iRhtkzAwsn2D
	 1PMm7myZd+Lzqconaxclo7Z2O3EnMYmwbpqaLib977qvGCum1sthjM0QPI1yxq0sbHmJ6
	 bFSy60xefWv2LLws3e06X96n6gBtQLsQGHccV7T+oCOCIn+PVqiqixxZLeM8q7lmvNcRN
	 oqcja71DS8yFQH9dV2O3wnPRX71Vzo3Z0KqFVtg5eHusp6INrU8doROlRNv1dE238tWgi
	 QFN0klkqLTCwnnbau5xkIUVhZf+Tl5qL7GTAgXI8re+IEBU7gdlybi0xw/4fbcbZhaw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836770;
	bh=s7pUc6CuM1fj6hUMbS6E0h3cbinHYq7YhOfXH6HnVoQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B3V3VR3hX24kKWxWIWcBxhJnLzGS9OxPw2JlxvNTfURpMACBbKr2GRmDx3kWY+SMv
	 ot00QpKz+ujNmUGBkvgJM3TiRZRaau8rv6tV1HJLMfWjVzo1lDnE1hOdGOqmQZarou
	 MwNSsvwUBYhCcrnTVlFCy/pIDn59c7z2u1QljRocLfa2X5yOEKsJNfEW9y1ZZwKsfP
	 PxgfWf8OZzCgbCNaP2cKLNFCkX5q/Tv+LjqT/uHxNYXvT3y/So4KGiFbQIfcgEPMQ3
	 MJlsuI6bgHfgnWn1ejLz1WXSLuepiYZOn//lzzrW/vRZgP38AeMooCR3UpOigKu+d2
	 tzqhyz1G04NiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87E0660739;
	Sat, 24 Oct 2026 10:12:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFB8E4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5F854009E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hhkUcF00Mir for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B5B4740068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836768;
 b=RtZP/4iBuitL3D7zz6qhkF1ggyqTNh3ttC+DkuRcfs6ZYzpVkgjIbZDaEryKOx95Wppj
 XKiLRF3Pe1PDmGHbTSPZF41SuiB7wq3mShTN20il+/Vi5EdCJyr7ohPU5qVRyVSN8FDHo
 5iP5JqPivLSM1HT+PuS/XQR6zUN+TDNeKs2DQQsT3vl4PQbsl3tD2LwRCQUiFYEb+lju9
 pdDbJNl+5E0m6jAa05JqMbyVVuusRTbIhH9cJsHdstdjbCY+q3pVn+cGOoXMb0ldyDkM3
 NukD8it9X7YP5m+M7rDm3DUjd8IoXKFXYElpFBI9gOBxJsV17lHR63r8HYnnS4ubWEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836768;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=s7pUc6CuM1fj6hUMbS6E0h3cbinHYq7YhOfXH6HnVoQ=;
 b=QJgTExjKD/USQ1kPm/tAtNxojM0Pnq6l/06L/In0KWoeIGTThp9sQuS0faWHIsm5wC27
 +Dvoc/D60P9kSGyxjnrEDeJtNt5xfnW1nF8n/d3Mx0AEIP6G96S2OLUJ+j+JJI0jd8tsH
 d9vjOIuYjKhh90BvmM8v8bX7/w7AM6ixmGSf4HHVsiqMVTssmgLj5FZNer238IfbR3cXO
 C84prf5HVCWgN579RQ3jB7pUViLWWGYavuLnEqYh3Jbo7DMOTUeeP70BuTTs23G2P63fP
 JT34/r/ODETlFXzoyF6RhlHNzeN+i13QhBtm1OymkRfKk/r1QoQ85pLJi/7Vn8G0Qog==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="g/jvgbU7"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=g/jvgbU7
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5B4740068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:48 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-539a57a0b1fso649765b6e.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836767; cv=none;
 d=google.com; s=arc-20260327;
 b=KWoWTh5A/XiBl6UhUWoZpAWhlFcGzVTY/ny8Y1jrOujOcb+utbWsWrgId+xveKZlE2
 IhwxkHzOLNHjLb2oZD5xTuW36rO1jGJgqfb3F6cWYlgZnRg6YekdfW4mBVDifFPfg1H8
 /RwuHoGKaz6Dpx/VA6/w8MnIYGGr3tHuK2y1yKowONSKhJZJU3PLSPYctReVwi6SzzMH
 y8nq8YEyBK0kvg6IzKO7G0sbh4XaIV3omM+rS3EJHKGRbBP2gwTVeUWhisg4+1bzTJ8v
 5qezK/tFbM6IdiYs8dCoA3zNgqXB1BLoUkuDFjEno0pa2REeHV5RY+gm2perC7filFWk
 iTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=s7pUc6CuM1fj6hUMbS6E0h3cbinHYq7YhOfXH6HnVoQ=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=YJW/T3yMF8BDkWsJeNF9nwxty7QltFrCEkmuHS8/kil6uT5xgCcsO2kN2Sc6sume0S
 5GHhQI5oCstNZa3sLx9HpFrbm64O7LA9weTJLeAk6lGkbvbJ4tnMpyQxo1y8zYJmgtPc
 w8FDnS8uT/HVoEjgKNQYGOidL23DR4jrI17d0LseOgJaN6DrWvYxuI1Gt2FhQDZDkULa
 aRsFfwqd0TFImiSopPe+bKF8FPp7Ad1uwZnymm7VB2HCmmJMBzBVoOF6/Cppkg9tGq4F
 PvYKV3EPirXYtG9cevvwBBVqssMFomB1wLd++A213UW0u/e4PSWGSfqzkmBM2jSF3zJq
 XXOQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836767; x=1793441567;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s7pUc6CuM1fj6hUMbS6E0h3cbinHYq7YhOfXH6HnVoQ=;
 b=g/jvgbU72v+7NqNO+vu5onyXnJphJRias9B0SwKohneSk7fMcTyuZKyHshHPIW802V
 xpkjc7Pd1g9L6fsm637vk50LuK0EXDPAFt6gD+xJ2xcxH4W8DkiCSaZ9z9TOBLsc6+1U
 OlVvtFrxwzcH9Vnz/ewcsLeqCM5fFOMsjsMwzc1xIPdwYERmuwvT0HjIBxKdzo8T3Qlc
 GGv26CQWR0wdz/DcOU5aQiqBxvvp0JCL6K4ACoMOQgcyZXuyPOssrgDne6udv/Ek/EwW
 iJ5gjF+GuAK3KHEEaPbBjj/W9GLEZiWQnZjLpOEB7f5ZKqzOT0GTOIbIh0Ozuz8tNYnr
 Mt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836767; x=1793441567;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s7pUc6CuM1fj6hUMbS6E0h3cbinHYq7YhOfXH6HnVoQ=;
 b=Iei/3UGV6mYZXkGjpv5X7ufxDox4CBuXHIya0FXP6HltnqLZmCLmtUDzM4esxeSJQJ
 sSDypnHwoT5dEAJuyvkLhMJufP9SqBOXmmEm6HCZUVIZnRFu1sA5FTWR84r+y8a7bZev
 gR5F6e+kfSAe5743UEDUPLb51BNfAF+GnekxTlcoWZR/wWdye/KvBBAPfUd0uvT+zqwz
 hYkwaFOuNqZFfOXJGUzVTyl2PIqF9N9G08xMjfX5oETwb0puqI9MNSQ1BBnW6WHCwEiE
 gGjdxjoCF2d61NHqS4WxI5ezQOA75OrubdV6ovr8TtMMvcLg7/l9xQGLADPCV0Bd/c7r
 MIHA==
X-Gm-Message-State: AFq9FYJdlHRqUma8DjjwSpnvMw7a0+9gqASQ1WR9R12jwgKRXx4ncKd9
 18lrMnHvpeUhTCQswZdyK7iy5tR0hEb6MmLS81L5r5h6qjaOqictubnGijpb4rpHxubsIkBLYxU
 BC8Ls1/KYWn8FV3KfPxvVNmxQr3QYF7DTgtwF
X-Gm-Gg: AYBFou3XFu/n+z1DZgxtPvbdxEemZxda/qEUFAmc3/hXFuwKim2tqOhAmMdKMDz711j
 dEDWzjDHqNCQ+QeYm5QPyVZYRbd/0vgWfikVdcvyvvpo8qBXuv2Rzfwkc+lH32dCC9BVw6wGmF3
 RPC4arFtQX4lXnJphTCwz8u4RIm7L1DJuj7sORPdrtXfTkMK9v27Un0HAMfZylXboltCOpFBxlh
 gDUEE458fSULfQ98eD2vDj071fWOJngIFcjpunjllZ85GPZAB8A0ISGDCGm804H/bIfyl5tpMh2
 hJSBdqWWuWx8U8qiGpzF9WxX3ba9GSnUk56+IoPoLRBMXGrvBzuOQa/FczWJyP0MMgZVO0WbdYZ
 VCvHRVw+7gZRUcjlBR/s4ZTRRCFcpucUiTOXJZw==
X-Received: by 2002:a05:6808:1b26:b0:4d3:9029:5ab3 with SMTP id
 5614622812f47-55c0032e6bemr982045b6e.35.1792836767195; Sat, 24 Oct 2026
 03:12:47 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:45 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:45 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:12:45 -0700
X-Gm-Features: AclHuK-Lh5-vu-vGen8cUKZBf8aYP0yKcPigrr7YiCmFDs3dmIJHHxMeQ3dmsYk
Message-ID: <CAJnxHshw3hOjKxPtmoUC_nVadd3xFGF_tx1MZOwMDUu8h00KAA@mail.gmail.com>
Subject: [PATCH 3/9] scsi: Refuse a block size the block layer cannot use
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000a64093065e93562d"
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

--000000000000a64093065e93562d
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000a64093065e93562d
Content-Type: text/plain; charset="utf-8"; name="0003.patch"
Content-Disposition: attachment; filename="0003.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8ef9dc8e6980ed52_0.1

c2NzaV9kZXRlY3RfZGV2KCkgdGFrZXMgdGhlIGJsb2NrIHNpemUgZnJvbSB0aGUgUkVBRCBDQVBB
Q0lUWSByZXBseSBvZgp0aGUgZGV2aWNlIGFzIGl0IGlzLiBkb19zY3NpX3NjYW5fb25lKCkgdGhl
biBoYW5kcyBpdCB0bwpibGtfY3JlYXRlX2RldmljZWYoKSBhcyBhbiBpbnQsIHdoaWNoIGRyb3Bz
IHRoZSB1cHBlciBiaXRzIG9mIHRoZQp1bnNpZ25lZCBsb25nLCBzbyB0aGUgYmxvY2sgbGF5ZXIg
bWF5IG5vdCBldmVuIHNlZSB0aGUgdmFsdWUgdGhlIGRldmljZQpyZXBvcnRlZC4KCkNoZWNrIHRo
ZSBibG9jayBzaXplIHdoZXJlIGl0IGlzIHJlYWQsIHNvIHRoYXQgbm8gYmxvY2sgZGV2aWNlIGlz
CmNyZWF0ZWQgZm9yIGEgZGlzayByZXBvcnRpbmcgb25lIHRoYXQgYmxrX3ZhbGlkX2Jsa3N6KCkg
cmVqZWN0cy4KCkFkZCBhIHRlc3Qgd2hlcmUgdGhlIHNhbmRib3ggU0NTSSBkaXNrIHJlcG9ydHMg
YW4gdW5zdXBwb3J0ZWQgYmxvY2sKc2l6ZS4KClNpZ25lZC1vZmYtYnk6IEFuYSBCb2JpbGxvIDxh
bmFib2JpbGxvM0BnbWFpbC5jb20+Ci0tLQogYXJjaC9zYW5kYm94L2luY2x1ZGUvYXNtL3Rlc3Qu
aCB8IDEwICsrKysrKysrKwogZHJpdmVycy9zY3NpL3NhbmRib3hfc2NzaS5jICAgICB8ICA4ICsr
KysrKysKIGRyaXZlcnMvc2NzaS9zY3NpLmMgICAgICAgICAgICAgfCAgNCArKysrCiB0ZXN0L2Rt
L3Njc2kuYyAgICAgICAgICAgICAgICAgIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9h
cmNoL3NhbmRib3gvaW5jbHVkZS9hc20vdGVzdC5oIGIvYXJjaC9zYW5kYm94L2luY2x1ZGUvYXNt
L3Rlc3QuaAppbmRleCBlNTU5MGQwMWE5Mi4uNzZlMmYxMWIwNTkgMTAwNjQ0Ci0tLSBhL2FyY2gv
c2FuZGJveC9pbmNsdWRlL2FzbS90ZXN0LmgKKysrIGIvYXJjaC9zYW5kYm94L2luY2x1ZGUvYXNt
L3Rlc3QuaApAQCAtMTMzLDYgKzEzMywxNiBAQCBpbnQgc2FuZGJveF91c2Jfa2V5Yl9hZGRfc3Ry
aW5nKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKnN0cik7CiAgKi8KIHZvaWQgc2Fu
ZGJveF9mbGFzaF9zZXRfYmxvY2tfc2l6ZShzdHJ1Y3QgdWRldmljZSAqZGV2LCBpbnQgYmxvY2tf
c2l6ZSk7CiAKKy8qKgorICogc2FuZGJveF9zY3NpX3NldF9ibG9ja19zaXplKCkgLSBTZXQgdGhl
IGJsb2NrIHNpemUgYSBTQ1NJIGRpc2sgcmVwb3J0cworICoKKyAqIEBkZXY6CVNhbmRib3ggU0NT
SSBjb250cm9sbGVyCisgKiBAYmxvY2tfc2l6ZToJQmxvY2sgc2l6ZSBpbiBieXRlcworICoKKyAq
IFRoZSBob3N0IHJlYWRzIGl0IHdoZW4gaXQgbmV4dCBzY2FucyB0aGUgYnVzLgorICovCit2b2lk
IHNhbmRib3hfc2NzaV9zZXRfYmxvY2tfc2l6ZShzdHJ1Y3QgdWRldmljZSAqZGV2LCBpbnQgYmxv
Y2tfc2l6ZSk7CisKIC8qKgogICogc2FuZGJveF9vc2RfZ2V0X21lbSgpIC0gZ2V0IHRoZSBpbnRl
cm5hbCBtZW1vcnkgb2YgYSBzYW5kYm94IE9TRAogICoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2Nz
aS9zYW5kYm94X3Njc2kuYyBiL2RyaXZlcnMvc2NzaS9zYW5kYm94X3Njc2kuYwppbmRleCA1ZjBi
MDFkODZkNS4uMzRmYzdjZGE5MTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9zYW5kYm94X3Nj
c2kuYworKysgYi9kcml2ZXJzL3Njc2kvc2FuZGJveF9zY3NpLmMKQEAgLTE0LDYgKzE0LDcgQEAK
ICNpbmNsdWRlIDxtYWxsb2MuaD4KICNpbmNsdWRlIDxzY3NpLmg+CiAjaW5jbHVkZSA8c2NzaV9l
bXVsLmg+CisjaW5jbHVkZSA8YXNtL3Rlc3QuaD4KIAogZW51bSB7CiAJU0FOREJPWF9TQ1NJX0JM
T0NLX0xFTgkJPSA1MTIsCkBAIC0xMTgsNiArMTE5LDEzIEBAIHN0YXRpYyBpbnQgc2FuZGJveF9z
Y3NpX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCiAJcmV0dXJuIDA7CiB9CiAKK3ZvaWQgc2Fu
ZGJveF9zY3NpX3NldF9ibG9ja19zaXplKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGludCBibG9ja19z
aXplKQoreworCXN0cnVjdCBzYW5kYm94X3Njc2lfcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihk
ZXYpOworCisJcHJpdi0+ZW1pbmZvLmJsb2NrX3NpemUgPSBibG9ja19zaXplOworfQorCiBzdGF0
aWMgaW50IHNhbmRib3hfc2NzaV9yZW1vdmUoc3RydWN0IHVkZXZpY2UgKmRldikKIHsKIAlzdHJ1
Y3Qgc2FuZGJveF9zY3NpX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoZGV2KTsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc2NzaS9zY3NpLmMgYi9kcml2ZXJzL3Njc2kvc2NzaS5jCmluZGV4IDUwZTdk
NzQ5OTIxLi5hNzMyZGI3MjZhYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL3Njc2kuYworKysg
Yi9kcml2ZXJzL3Njc2kvc2NzaS5jCkBAIC01NDMsNiArNTQzLDEwIEBAIHN0YXRpYyBpbnQgc2Nz
aV9kZXRlY3RfZGV2KHN0cnVjdCB1ZGV2aWNlICpkZXYsIGludCB0YXJnZXQsIGludCBsdW4sCiAJ
CXNjc2lfcHJpbnRfZXJyb3IocGNjYik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KKwlpZiAoIWJs
a192YWxpZF9ibGtzeihibGtzeikpIHsKKwkJcHJpbnRmKCJVbnN1cHBvcnRlZCBibG9jayBzaXpl
ICVsdVxuIiwgYmxrc3opOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CiAJZGV2X2Rlc2MtPmxiYSA9
IGNhcGFjaXR5OwogCWRldl9kZXNjLT5ibGtzeiA9IGJsa3N6OwogCWRldl9kZXNjLT5sb2cyYmxr
c3ogPSBMT0cyKGRldl9kZXNjLT5ibGtzeik7CmRpZmYgLS1naXQgYS90ZXN0L2RtL3Njc2kuYyBi
L3Rlc3QvZG0vc2NzaS5jCmluZGV4IDY2ODU5Yzk5MWRmLi43NjE3ZWU1NDg5MyAxMDA2NDQKLS0t
IGEvdGVzdC9kbS9zY3NpLmMKKysrIGIvdGVzdC9kbS9zY3NpLmMKQEAgLTYsNiArNiw3IEBACiAj
aW5jbHVkZSA8ZG0uaD4KICNpbmNsdWRlIDxwYXJ0Lmg+CiAjaW5jbHVkZSA8c2NzaS5oPgorI2lu
Y2x1ZGUgPGFzbS90ZXN0Lmg+CiAjaW5jbHVkZSA8ZG0vdGVzdC5oPgogI2luY2x1ZGUgPHRlc3Qv
dGVzdC5oPgogI2luY2x1ZGUgPHRlc3QvdXQuaD4KQEAgLTM2LDMgKzM3LDM5IEBAIHN0YXRpYyBp
bnQgZG1fdGVzdF9zY3NpX2Jhc2Uoc3RydWN0IHVuaXRfdGVzdF9zdGF0ZSAqdXRzKQogCXJldHVy
biAwOwogfQogRE1fVEVTVChkbV90ZXN0X3Njc2lfYmFzZSwgVVRGX1NDQU5fUERBVEEgfCBVVEZf
U0NBTl9GRFQpOworCisvKiBUZXN0IHRoYXQgYSBkaXNrIHJlcG9ydGluZyBhbiB1bnN1cHBvcnRl
ZCBibG9jayBzaXplIGlzIHJlZnVzZWQgKi8KK3N0YXRpYyBpbnQgZG1fdGVzdF9zY3NpX2Jsa3N6
KHN0cnVjdCB1bml0X3Rlc3Rfc3RhdGUgKnV0cykKK3sKKwlzdGF0aWMgY29uc3Qgc3RydWN0IHsK
KwkJaW50IGJsa3N6OworCQlib29sIG9rOworCX0gY2FzZXNbXSA9IHsKKwkJeyAyNTYsIGZhbHNl
IH0sCisJCXsgNTIwLCBmYWxzZSB9LAorCQl7IDIgKiBCTEtfTUFYX0JMS1NaLCBmYWxzZSB9LAor
CQl7IFNaXzRLLCB0cnVlIH0sCisJfTsKKwlzdHJ1Y3QgdWRldmljZSAqZGV2LCAqYmxrOworCXN0
cnVjdCBibGtfZGVzYyAqZGVzYzsKKwlpbnQgaSwgcmV0OworCisJdXRfYXNzZXJ0b2sodWNsYXNz
X2ZpcnN0X2RldmljZV9lcnIoVUNMQVNTX1NDU0ksICZkZXYpKTsKKworCWZvciAoaSA9IDA7IGkg
PCBBUlJBWV9TSVpFKGNhc2VzKTsgaSsrKSB7CisJCXNhbmRib3hfc2NzaV9zZXRfYmxvY2tfc2l6
ZShkZXYsIGNhc2VzW2ldLmJsa3N6KTsKKwkJdXRfYXNzZXJ0b2soc2NzaV9zY2FuKGZhbHNlKSk7
CisKKwkJcmV0ID0gZGV2aWNlX2ZpbmRfZmlyc3RfY2hpbGRfYnlfdWNsYXNzKGRldiwgVUNMQVNT
X0JMSywgJmJsayk7CisJCWlmICghY2FzZXNbaV0ub2spIHsKKwkJCXV0X2Fzc2VydGVxKC1FTk9E
RVYsIHJldCk7CisJCQljb250aW51ZTsKKwkJfQorCQl1dF9hc3NlcnRvayhyZXQpOworCQlkZXNj
ID0gZGV2X2dldF91Y2xhc3NfcGxhdChibGspOworCQl1dF9hc3NlcnRlcShjYXNlc1tpXS5ibGtz
eiwgZGVzYy0+Ymxrc3opOworCX0KKworCXJldHVybiAwOworfQorRE1fVEVTVChkbV90ZXN0X3Nj
c2lfYmxrc3osIFVURl9TQ0FOX1BEQVRBIHwgVVRGX1NDQU5fRkRUKTsK
--000000000000a64093065e93562d--
