Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44205C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 07:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D0AD80DDA;
	Tue, 22 Sep 2026 07:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKF9kJojjRZb; Tue, 22 Sep 2026 07:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D2EB380DCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790062589;
	b=N7n/olglif/r8FA1kjTuYHmHM3qTGz7GPIgY/7GxOa71dJIutAJ/46+IxmsTjuHFTuE8
	 hy9jgTsMBAYfCqUJcS4F5gY4cJuHqQgkRDdnJmhNrkFZjvkiOjxHBpVGJU+r8Vk3UM3hi
	 6BZoeM5eNi5tGOaI+XEgoJHoTLfWwQgE2HKTDCpA95qA30nrMgAUSoLpQ5RQ60L9GZ5pK
	 tLQcbUhjbBRhJgh6iCVl9p0LTaM1Q73XcMSKOtq2fS8BExCcgkdDetgsmGe6NfX+00mci
	 B2yGdBRSlMJgNx0QAWYjRPvIYt5pxFMKfG7hDPKtOsdu4dPjTj693lHyLpN/uZ7N1UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790062589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CyCIIX91doKmZIH5MYz4MpO4qCsoloy3ZMEWBe1q+Pg=;
	b=Nqzyc/1o5hRoebqX4CScBNvtqmDd7OySf/RLNHX4aJ3Wu1z94FDD0gIV0n7YQ17ai6aZ
	 ZzTxI1N1v3OA/tqBeFvi11THole0vg+ldBS7aTRei6pDVXhNhPl1K2A1Zhx+6MtK+IJCh
	 gatXZ3aTlm9gSLCOG6Ff59jv6ZGgFFpf4x5DBkzDZgFAgXj/0Hx4H59JvTTZr5oAeVlU/
	 5CO2fkStGTuL5LDxmqKh5TFfJiwZJiRQdr7QamFmqAVXVKDKSUC9CzWv5qrFZIKGyWsnu
	 uRCaKuzAW4NG/+2Z8EHmPvc2bPiBizuwxK3cJ3ujSRA6Gute+7YJtlR+YETY7z1lT1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZC/DrwSY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790062589;
	bh=CyCIIX91doKmZIH5MYz4MpO4qCsoloy3ZMEWBe1q+Pg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S3QRJto8Xit0uEMlWKBSXR++gRRWIXCc3dPyD9acVumzeBcMGIS/ZRRdFPCM1WvH2
	 oe4N74yLfQsjF5BnM7mmL1lAnJPglS5aiSBhQCH0z40hivTrU0T1QrqnwiT5HhB+P+
	 tFylzXiuEO/atXUt3L/16I8R8Vz4rcJKTPysZhTe6RvnqfMOlkFoGl1qt9zDPeLjEV
	 9VKLFwTMZ3TGXhXQD4L9+sPLLf1pfPu6gRv3Ab6oCYpOiYYz2tsHosR+fjw/PKueiq
	 LylEISOyKs2/nqNX7zneEv5QfUsiM/InlRc89ILt0vCrc2XfcjlBNXnc8gUjMWqoxp
	 isaQrUCL+u/8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2EB380DCC;
	Tue, 22 Sep 2026 07:36:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 084B89D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 07:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05C5980CA3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 07:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_Vr7GG5bYli for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 07:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 66D8380DCC
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790062587;
 b=os6p5KxvBxKdNXEsMx1vOeOZqlQexCqrBAsuMwtJocdZ+pUdynClqK8vN4GN3HfRrEAC
 pP12Ut+vOO+fRUOLWhxsFl/7JMTSHB6jt0QCUsn5UUafiv6gRI1L2mvg/Er03jXlUohun
 9gQocO2MC5CV347K9z6TNrh0+Ph2zp08TJDlpKAcDajmdT0ktB6GZFQIoYRJoTF9tvtFs
 kzSjHlGKiZpKl39joSNIqN8OyV+ATJW9fDt1I0hEPoNgqtdZzfKREhtpXQOkeNaMb6xze
 zpLDisE7w4/eQWAz/+luRdMten9A93JIYU5renpLx71EAVXnnKVGQU8j1zlQFqHL6Vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790062587;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=CyCIIX91doKmZIH5MYz4MpO4qCsoloy3ZMEWBe1q+Pg=;
 b=fJMYehRJUVzkis8Sy5qWCInjh9Q8eVyjwjeDriKNucZcBOhAsi56Yh73Tj24dIMvjTtB
 ZOd7NuOJkqy+l+mohUbZunfbSyhLzmMsFRytd6Y7LRV7zS1h5waiNe0U9LVYBoj/3d50N
 /kYMPpWk96b/QRnjUnQUVS81vYNW6ILxtkxFZKinNOSabRrk2KiTeJwdzq0P92hoX64ix
 tkqbIcL/AiExeVYfMb9kfwCq9Y6WSqSDGs6nGe4addLZ2iKEK7QHLI3e9MmTV1wXHwLU/
 DOGIB4HzRMuKQ4rQRaGmfSEMtoHR6+nOxn1eDmbegP4aPyr9XGDUOeV1y+R6N5+THVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="ZC/DrwSY"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZC/DrwSY
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66D8380DCC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 07:36:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A11D6600CB;
 Tue, 22 Sep 2026 07:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF4B1F000FF;
 Tue, 22 Sep 2026 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790062584;
 bh=CyCIIX91doKmZIH5MYz4MpO4qCsoloy3ZMEWBe1q+Pg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZC/DrwSY4yB7G0dz16PwZxN3JoHm3nd7XiM6Jh3LQkHtFbe8LN9wbJgo97cPWKyHb
 wlT4/CI/cLIwT0iQQn0pmxe592o2YxiJkbpNjPyAxEn/7RZLppsnnfIALsaSvB/IHc
 tOI+YaDJkrENEHAwguWxSRQy+Wky0ipUGukotg2bgZJ3Gml2KY4kKvZ0HJqh7+C1a6
 VZwwyywW6p3J04Fosba22QH19rMQvmcCZoa76iLI1gpZwRXY/7iU7XxOCww8pa2EKc
 k3FkjAgYyNEUwLdjt+HbVAP3wul5kYDued2c7lxVSHdZHfJauEU8oo/Jw+x2RsXQpX
 BfGfWRKVo8mXA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Fix Lukasz email
In-Reply-To: <20260921220620.151189-1-marex@nabladev.com>
References: <20260921220620.151189-1-marex@nabladev.com>
Date: Tue, 22 Sep 2026 09:36:21 +0200
Message-ID: <xhkdbh5jhspoq.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the patch.
This has been bothering me for a while now :)

On Tue, Sep 22, 2026 at 00:05, Marek Vasut <marex@nabladev.com> wrote:

> Update Lukasz email and .mailmap entry.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

