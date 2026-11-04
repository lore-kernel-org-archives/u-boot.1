Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B5606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dXedEE6z;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9O3bh6l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF08D40663;
	Wed,  4 Nov 2026 13:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VT7GFjcjiCvQ; Wed,  4 Nov 2026 13:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4414E406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797208;
	b=Sd83uEgAuXv0FlbxFBcrB/XqkPNVKZCr8eKjCN6Vr7fWeiT7ShaCUCLz/wxGerjdy7Xc
	 9aLAG9136OsAEsMmTHGsWCbpuLqzTchqfvn6LhY4hRbz5OgACuKgJWslZE7+3+bneXYZq
	 6p7YrxFbIdk/OhZE1vJ65kTnOT+19MhaObNNj+7ORi2rx70YCcE6b26pRkKmnle5D4m73
	 lNfEWhcGOasxpxa2HbtcPIzNniwYx0l/f4fScYYUrejvbIHKsiwu/4EpzX9VUPa59L1nA
	 1A32mpU+lZFqGwPa/JFtQTQ5tSfjDpRnUwNS3QRLmpdBRwcr3MMuCjpnxFjWGDbPw9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3EThT9QODuQHIaiCcB4H+2p92Dg3I78HbNKVsu6nwkk=;
	b=rCaByZcF/o5EUQc3abFdTnPbhSdjAMjAcgX4Yr8nIiWamroEGXd/fRQr9V8IknvWSLic
	 6RL+8/JcyOq820sScMcBIf3ytq8nfjvVYfgpWsCX9+SG/0hgjDryT5HoTCey0z9k3qMAk
	 hfveQL+0OFw+3cfc+CcneEpr+s4a1WYaeuv+bYA0Kr+uxAyqMB14omyb2rvn9pcgyagBG
	 DQ6dTEyTzHTkJniWxaEU7AjhpfZpV+N8FiZ+Gt+EUvg7CDrBFPBdH5UnCsiBA4rQvjiXz
	 HkSVdVjoG0STc3GPafVZwUuRsKlnLyDArc9rbDIwYtYZ2+uwPHZBve0KT1EYMUFyVDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797208;
	bh=3EThT9QODuQHIaiCcB4H+2p92Dg3I78HbNKVsu6nwkk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dXedEE6zJjhJZX1lYWv0LhFF7DEAsIsvySeiQWfXNxSpyRtW+Eu4mAotRY5WX7X/z
	 CCAc8RpIM8HnIgYKPdbvD7MgDMqt4rffAuKtQbCHGMUHT2h5kFR+uVriel/Vw2ggaG
	 eUpzu87NBAvodpibW7RQKgepYGlYRiWBlQcDr932rKcDxRn4Re8mA40H4QJPJqTDLs
	 maJKw+y18Xt2KM1VrK00Wt9l6oG2zi19mwgGIWSNtXWsFHSFyFJxT3pNov1MFoEBof
	 1tthP72lnLmzKlsFdUa/R5yMEqOSthxictawzd0Q9SMNflPdRTZXPedxPd0GMw1D8K
	 C+aVOzklRv2gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4414E406AE;
	Wed,  4 Nov 2026 13:00:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBB52341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADAA0606F2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BIOOVDjFjW_U for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 13:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC958606EC
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793797206;
 b=Y/l++0saDoPObpTVGezYdZ8vqhpOLiTym431+/UvlRrEL18eCmAv1wE2zAw196bo8sNG
 NNuMMyPerehwfw+EVtxxkHsLOR0tJMljrylLasjMOOyDlYTRKC+4Cg/+Xl1+21p26xG4U
 Nbjc+qDUMO04sY6CAuqqau1A6yDB7MTHKyVXm/rw7dOe3X6M3ZPpFDmH/5F88ISh8cRZb
 ooGDCgWrJEH7qMf+xVhOYuc0Mc7FjHKsI6F1rGbX7J7yMZcOozcQlGGwbAFQfCODqCuEH
 LBKqPPaqV6QLpcV7TCBVtv9on05d4Pj6JSe8106JXgHAUG4KQoIJCGNF81xwiygxc1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797206;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=3EThT9QODuQHIaiCcB4H+2p92Dg3I78HbNKVsu6nwkk=;
 b=B3sLh4fWwLUcfb3aYKGktkyNXlIxXuHGrRP61SgUcxqvGHHp3R09FmWGHifSXvya9rPQ
 VSb37xReaLTXi9fNKAVTg2DIj+kVtXziU+rPLa0h027x+sTUNMikU3aEmM6IL2r4j+uta
 eEU2yXQWjanlH3UlvAmG9eYq4ADytJ26HHJTAkxQ17tzqZGMdW2q/EZvgrqSNfNsY5/OL
 /qPZl/vpns854sNoC5cv2Mu5I9Y1atO1d9X4//R7DLwuatYgjQNph9HGqJoFBxQ/LWC8L
 OR7k8tatUo15BlgxFNHgN5GObuZxAz3/urojY0Do2fSmEB6nT5U12WJNbeEWUrlHGfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B9O3bh6l; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B9O3bh6l
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC958606EC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF33741449;
 Wed,  4 Nov 2026 13:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7274E1F000C1;
 Wed,  4 Nov 2026 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793797204;
 bh=3EThT9QODuQHIaiCcB4H+2p92Dg3I78HbNKVsu6nwkk=;
 h=From:Subject:Date:To:Cc;
 b=B9O3bh6laJ1/1+sYUJcbfQslynOQdScI4a10KOajNV/EdKL41EFRjhe3orLMmUAMY
 eSf/ohfzfo3ntyHGo8aHSZdAiZsrz6IFL1zn7LF0QdRi6olbMshe1FXBAl5rYQeDgi
 MY+icJmh9SmRbhobvQC/eiuGwYp4e8GpIgRpYPTfKzT20GhXNbp2P7VqPIKkg7/E/A
 aXn4/OpcCQmX5KRr0FEedBRo/5GvPgjFC8g1XR3iUrZxUNaQa7vfsTdcVGXijN7xmJ
 Otu/Pw/ZKQaOdPrMUmyXU5NyKx7d1pXiI3oT2wTDvlWAMRiGgOFQUi+DGs2RHHcQEG
 S2qa/d1F6pqpA==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/2] gpio: spacemit: fix bias flags lost problem
Date: Wed, 04 Nov 2026 12:59:50 +0000
Message-Id: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJpxgQr2JYYGeoow00LRgTw
 t2tuHyL/zfIklQyXKsNkrw16zwV0KkC9xgmL6hcDNbYhsic0Vh81eijzhjXEHAMg0dHLXfcEfO
 lhZLGJKN+ju2t/zuv96e45feCff8CjBwie3gAAAA=
X-Change-ID: 20261104-02-k3-gpio-pull-flag-c17d9d91dd87
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=dlan@kernel.org;
 h=from:subject:message-id; bh=bMsd1FmWJ3nQeF6lbVyrVgjJ41ccqwY/8om7AsqpZv8=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq6yxIdUjeNcyYkGeep6oSdqncFml8SwbPZjeqO
 q621nbS3FuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaussSBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2MWw/9FZN/cAt8d5bJ+Gu6hGlrmXuIZY84I/EBV/UFVs4G+FiAzmDCPCyn1
 5MsT1w+CUyxZXRCmuuiSWmZHgTtWf7YCLiOO0zMeJhZzfo/RkKAOHyJhDxXsQvGEvhtT09CFsoO
 SXW/2w/1oaByYeqtTTZepNN+mHqGSjXjUU5oaDsEPbRdRfLEKWFBzL18XIzEesF4uFPgHy/0cpa
 cumGIQ+rAPOoEP+LHXclvGH/s0Ouw+09ZYQ2gdsFNVWeKjTdzkgPxA8p/fw82ElKsOzGcsE+ynl
 vmUjIKDOXDXaLyjqfh7LcOQwQGstfVLOrRiUZrhC0MicvLZuBzIYEki4U4tzUod2zmWxNvePEfY
 hwU75YEs4sPzaBZQiFRVwmKMcDMTfHqst8/TbQ0QNzPBJFboGTaR0CWP7DQIGqqXuSngZhWfMgN
 dnd/PCxip5avrLtxHSWmPqJbEaVYyKcRKXKMR1twqvYUE3DAOIpG8VkcRQwQzMYXiEA3VtKcdf9
 gOVuferO27qmVj5UTvnO9j6mfLUj1e1+kEEUrY3w5Us5OPXOnlbH4b7sQFm1ZwDvPEOyoeIkue5
 nWV2Peco5YObUp52k8i+EUvDfygd9Z3TdnQIhW8+i5BdRsUPLdlD5sZXcwKY9LgxXY1u/8qDLN9
 volUeh1ujcts5twSIkudK7woUIBuYA=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fix the gpio bias flags which not configured when passed
from DT property.

The problem was found when testing SD card CD pin (Card Detect pin)
in K3 SoC, which we need to set internal pull up settings
 cd-gpios = <&gpio K3_GPIO(4) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; 

Without this patch, GPIO_PULL_UP configuration will be lost, and
result using a wrong default reset settings.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (2):
      gpio: spacemit: cache pinctrl dev
      gpio: spacemit: propagate GPIO bias flag

 drivers/gpio/spacemit_gpio.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261104-02-k3-gpio-pull-flag-c17d9d91dd87

Best regards,
--  
Yixun Lan <dlan@kernel.org>

