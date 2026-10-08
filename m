Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0039ECA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2563B8125F;
	Thu,  8 Oct 2026 12:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IU_eNfq4bB7; Thu,  8 Oct 2026 12:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 36F78811FD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463577;
	b=bbk2u494oG+a0DcbvGMbNiQher42kyqWI8RNMIc/62ZyU0LK5VyxNkFEkjSHPXlMaXg6
	 zptPEcJDxHZKg/uBm/TEaJxB29sbBJeowN3Ni0ce/G5EwJ9CMna7G7Njfc2/FHlYalWsX
	 t7XHYTcGt7gA/HLdArV7kfsvOdPpwGJZTW2YJjjXTGWFkZ4BQ0cRU0FzZgrwJT4s23H36
	 Qaev5+ZrwEttxjuFTMk5DwO3HZQIWT1W4AT/+b+HwSa6wC/TrApYrRXtCSliwnEdbuQNH
	 AQXiUwYCskzQKAjyOB5fqF0TwUIcevH4btA2dLjmfX7vrD6+TBQJjA0xJcHmuVuz2hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
	b=OjGq/+q9MYL51sudgo22BpieTxtE9QgYxy5FzuxVVSwoNyAPemyS0lWqXQPKC74dUuvr
	 nIuQ5beokbnuWXYnM76Q5c/WA1XglD1/ml4ArIh/vzTUEVPN5pd5yVD6/ZjlFfgv3lF/J
	 qDiGnv4+jmVWp/giB8Hp65BMFOVctM7sp+nmAICeO9VHapJs33RSwkUnxx3xZGA2ZLwxb
	 zicjOwYcnr/2QnL+pvc7Z1zG+TfnIQXfgY7pq04C7iFAB50xNBB/J0Wl4FfNcAnP4NzXW
	 RLtSQ8NXXo5ihpvOk4syHZpQJ/qZKz7LITdJpFMJrUGGYQctaQPXi5hpJlcMe8HllbQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463577;
	bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ve8Gxim78tHePpYw/oBAB9ZHpN/MtWLqA7pzBTC6YcUwtqdZuzGmOm6DZt/1ZnP+o
	 O1S1eSmWWkZqh5R60xOb4DBW/8r/1dUrwDZL+c4V2FwMn0dsW4Qt+ovSwcaD2xRW78
	 n3Df7/ifGectUttcHFNVIufvA67lFghb7QvM2Dz3EysZRP/Kh11KwMsXuLIX31AavT
	 XwftN5H+KYqK4Xgdw7ezgu88onrNWwqjv7QiwIy9zyihZtyrGKrfWn7VktZ+CpAnMY
	 Gke9MgSJwnu10Qxkb7o1Q2R9Uph91lYzygbClCpMgiuSTsZ5O00zQmIHa9VpOq5Y1E
	 K5H3wAaA+l4UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36F78811FD;
	Thu,  8 Oct 2026 12:46:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D8B534E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F8AC40456
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KIR-MyquHqqu for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 016834043C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463574;
 b=W34DM0+UNIawKoS0DC+kIBu7rTlrYLNFO+v1XwzQLEk97s6XO5KR6XTG1vfSti3aUKjX
 77152L+SN19A7dk5fj62Z5nqQNiX/ISywgUae9DIgi3yA0N2AmQoFw3pwhAvs9g6+21tT
 A3hr/hPthVpC8O9MxYVYwqFrA95RIdx212gm+jhs16MVYntctmy8NagCWarJRf1keC/3h
 fMnUfyYAbYmID7mpCfwz+HYZQtsdg0NnhNkA/+vdw3Q65ulDV3tPS8L6CHYffPfNc5ewU
 xfSywXSsJTa52GAIYf0AziDi7P7+1iji8CBfXD5qr98JqJCkrFXOHd0hv0fhDgVQp7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463574;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
 b=EHLDIH9VxwUUDWYTVwVwMfMPUSLGB14WuBkWmZIrumIdvBngExzb+NgrjLvlpPHB70GK
 LVEXOeOZQFWw8NuI9qKSRXMNdeVjWhp39L2HNDw/jcqydhhGbO9jnJPSoX2UoDEWNPdfC
 68a3NFYv/Yh/0vN3eSKbMzLZEnq4sIbDIcQrLTvB8I1xiAQkMpn4hSLvEmSEhlgTRrEzt
 ZeqvPjPMTi4Gj6lT6OK6cGy1+B9xSfLVnhTqYHbNABpF+Fsp3vc2JKdmI0MB8fnZPND8x
 QnBgMI1FJupwfC2e+TpmjTTZyK/ERXoYSgqp/fgGE4o6C56VR1sB4SoSVMpH9z7FxJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lK06LxuS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=lK06LxuS
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 016834043C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:13 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso24055155e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463571; x=1792068371;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
 b=lK06LxuSnGi94L/0DuexGWyon4QQv5SwYu4yNXIYUYtwJqh8FFyVMG2rGfdfX1HnBQ
 9G6pUFdXyY6n7ZZe1aMYIwGFGxjw0fInfDm4EQLokZDTX/IVKfZphgPoYgyHUZ36a8G5
 sRccw0oBvF86Fq7AbTbB36HjJPqQyNyuAPvlg/TVK7PamzCgoZnuwquQ1T4pWTB4c+gL
 mAmeWx5wdAfBndOrvXbqCFxjIXJxyBKEOrkV07eX/Dejxs9ypDD/XsQWtZTQ0/T/6SQc
 z7q9XAOThhcD6LmUDS8MfTyTgu/PoFHoqPU/taLmkP8vGJg/W8Wcne3ufQVlGnUOrSrz
 DMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463571; x=1792068371;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/r0eZQ+QwOkKC/EpCQ7wf6/3GcygC3j9nEkVwHYoeEc=;
 b=r0XcM5AqfecEftzvM3wONFI0SByshoJ5+ujX1097qzesePqPbhzl43AU9t3IPWmV+e
 XQd/qdG0LXdM1u5LnOL4eO5ELo5VSqhxTiO/dPdu3+1D2OmmZK3C/Py9PduZ+8oKcwC9
 2vwJpIqwR637vGOp7F8MTUSqZatKKvaBl7pnGC5Q6w8TDw/oC6eg2Tgfu0HvAmp+kYl4
 14pCqRkhX0Es6qrc6Fh2YMJRovNwtx1JRH3f+dy/R8vL8yxrNoPAZIEApuXzkg++2fGF
 048hAwWoHdrv5VJhm7v1tNAlyakE18zLVPxdrqZzA0ZEZTib8qRwRNpzQV0lgyFq+f/R
 ZctQ==
X-Gm-Message-State: AFuF++mGDEl4yijP48nbhDvvqznHFmD1GYydjjQu+hkjwPusetiMklCF
 +CxGt65h5sK4eoP3RD0fEG+Vmn2Pckie+E5zNB2EcZWqUHn4SPp1kt0d01tTAUNtJddOJDpmmFM
 NzDZro/Y6Sg==
X-Gm-Gg: AYBFou0xG5hbCXk+ibeVRiyO4YyoM1VHPDxluQW30DL8Jlv3BzYh8n4qQXpXktfCeIc
 Qdm2SeA8hRGh3ySOCRWmF6QhxeDBioKyLADWPt5uRrBrM/1PQHOu9azBLzq+S7uVotF71AWS1iq
 xl8hyQAW33e4xSdU95B+LwH7jZkL5xgICZpBzl+Sq2N8ohI7E+SSolf8W068IZpSB/tFtWKlKrc
 OKyotYIAXAcSFNZButAGUte9WH+wOIR+LHptGbbwaVc0POgS6MjAOCe4qWCIX2rAdD/MMyFVDbW
 H5uZXqH6VVA41xflM4rTWGtLwh6NMTPs7yL0A6EfIMmu4+1psEm2OgJ2IL9znz+qjA4aAv8xU4c
 vp8mHYaN9ysKsLE5XpZnfx/Zm4Qu7Yvo9HYpdfjLsWHbxkIJrfyYKOSZQFSMBVazZwvi7KHrVbR
 YBPliSgputaTcdeGy1+VqyJ88WS4HIO6JptALA7jy1ejUpAGNwxMHuZigMfVHFkDJLL9qgXK2A4
 2TJ931eiClNdwhTRKK5
X-Received: by 2002:a05:600c:a00e:b0:4a0:1a18:b742 with SMTP id
 5b1f17b1804b1-4a1800d3de4mr103393365e9.2.1791463571207; 
 Thu, 08 Oct 2026 05:46:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260817163604.1893382-1-sanderson@brivo.com>
References: <20260817163604.1893382-1-sanderson@brivo.com>
Subject: Re: [PATCH] reset: meson: Add s4 support
Message-Id: <179146356917.183177.1543337014834269186.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Hi,

On Mon, 17 Aug 2026 12:35:56 -0400, Sean Anderson wrote:
> Add s4 support. There are no new features, so just define the layout
> info.

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] reset: meson: Add s4 support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fd46e031ba477a76af20b12f25b797d9d5997a2a

-- 
Neil

